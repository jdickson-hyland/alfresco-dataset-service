package org.alfresco.datasetservice.webscript;

import org.alfresco.datasetservice.model.DatasetInfo;
import org.alfresco.datasetservice.service.DatasetService;
import org.alfresco.service.cmr.repository.NodeRef;
import org.springframework.extensions.webscripts.WebScriptRequest;
import org.springframework.extensions.webscripts.WebScriptResponse;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

import java.io.IOException;

public class DatasetCreateWebScript extends AbstractDssWebScript {

    // Jackson preserves JSON object key order (insertion order); org.json does not.
    private static final ObjectMapper MAPPER = new ObjectMapper();

    private DatasetService datasetService;

    public void setDatasetService(DatasetService datasetService) {
        this.datasetService = datasetService;
    }

    @Override
    public void execute(WebScriptRequest req, WebScriptResponse res) throws IOException {
        String body = readBody(req);
        if (body == null || body.trim().isEmpty()) {
            writeError(res, 400, "Request body is required");
            return;
        }

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

        String name = payload.path("name").asText("").trim();
        if (name.isEmpty()) {
            writeError(res, 400, "Dataset name is required");
            return;
        }

        String jsonContent;
        if (payload.has("schema")) {
            // A dataset instance: references a schema and holds records. Stored under its plain name.
            if (name.endsWith("_schema.json")) {
                writeError(res, 400, "A dataset instance name must not end with '_schema.json'");
                return;
            }
            String schema = payload.path("schema").asText("").trim();
            if (schema.isEmpty() || datasetService.getDatasetNodeByName(schema) == null) {
                writeError(res, 400, "Unknown schema: " + schema);
                return;
            }
            ObjectNode instance = MAPPER.createObjectNode();
            instance.put("schema", schema);
            JsonNode records = payload.get("records");
            instance.set("records", (records != null && records.isArray()) ? records : MAPPER.createArrayNode());
            jsonContent = MAPPER.writeValueAsString(instance);
        } else {
            // A schema document: stored as "<name>_schema.json"; 'data' is its template
            name = toSchemaName(name);
            jsonContent = payload.has("data") ? MAPPER.writeValueAsString(payload.get("data")) : "{}";
        }

        try {
            NodeRef nodeRef = datasetService.createDataset(
                name,
                payload.path("description").asText(""),
                jsonContent
            );
            DatasetInfo info = datasetService.getDataset(nodeRef, false);
            res.setStatus(201);
            writeJson(res, info.toJson().toString());
        } catch (IllegalArgumentException e) {
            writeError(res, 400, e.getMessage());
        } catch (Exception e) {
            writeError(res, 500, e.getMessage());
        }
    }
}
