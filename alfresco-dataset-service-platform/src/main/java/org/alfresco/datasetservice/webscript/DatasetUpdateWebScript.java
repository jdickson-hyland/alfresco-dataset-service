package org.alfresco.datasetservice.webscript;

import org.alfresco.datasetservice.model.DatasetInfo;
import org.alfresco.datasetservice.service.DatasetService;
import org.alfresco.service.cmr.repository.InvalidNodeRefException;
import org.alfresco.service.cmr.repository.NodeRef;
import org.springframework.extensions.webscripts.WebScriptRequest;
import org.springframework.extensions.webscripts.WebScriptResponse;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;

public class DatasetUpdateWebScript extends AbstractDssWebScript {

    // Jackson preserves JSON object key order (insertion order); org.json does not.
    private static final ObjectMapper MAPPER = new ObjectMapper();

    private DatasetService datasetService;

    public void setDatasetService(DatasetService datasetService) {
        this.datasetService = datasetService;
    }

    @Override
    public void execute(WebScriptRequest req, WebScriptResponse res) throws IOException {
        String name = extractDatasetName(req);
        if (name == null) {
            writeError(res, 400, "Missing dataset name");
            return;
        }
        NodeRef nodeRef = datasetService.getDatasetNodeByName(name);
        if (nodeRef == null) {
            writeError(res, 404, "Dataset not found: " + name);
            return;
        }

        String body = readBody(req);
        JsonNode payload;
        try {
            payload = MAPPER.readTree(body);
        } catch (Exception e) {
            writeError(res, 400, "Invalid JSON payload: " + e.getMessage());
            return;
        }
        if (payload == null || !payload.isObject()) {
            writeError(res, 400, "Request body must be a JSON object");
            return;
        }

        // 'data' (when present) replaces the whole document; Jackson keeps the field order
        String jsonContent = payload.has("data") ? MAPPER.writeValueAsString(payload.get("data")) : null;

        // A rename keeps the "<name>_schema.json" convention for schemas only; instances stay plain.
        String bodyName = payload.has("name") ? payload.get("name").asText() : null;
        String newName = name.endsWith("_schema.json") ? toSchemaName(bodyName) : bodyName;
        String description = payload.has("description") ? payload.get("description").asText() : null;

        try {
            NodeRef updated = datasetService.updateDataset(
                nodeRef,
                newName,
                description,
                jsonContent
            );
            DatasetInfo info = datasetService.getDataset(updated, false);
            writeJson(res, info.toJson().toString());
        } catch (IllegalArgumentException e) {
            writeError(res, 400, e.getMessage());
        } catch (InvalidNodeRefException e) {
            writeError(res, 404, "Dataset not found: " + nodeRef);
        } catch (Exception e) {
            writeError(res, 500, e.getMessage());
        }
    }
}
