package org.alfresco.datasetservice.webscript;

import org.alfresco.datasetservice.service.DatasetService;
import org.alfresco.service.cmr.repository.InvalidNodeRefException;
import org.alfresco.service.cmr.repository.NodeRef;
import org.springframework.extensions.webscripts.WebScriptRequest;
import org.springframework.extensions.webscripts.WebScriptResponse;
import org.json.JSONObject;
import org.json.JSONTokener;

import java.io.IOException;

public class DatasetElementAddWebScript extends AbstractDssWebScript {

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
        String field = readField(req);

        JSONObject payload;
        try {
            payload = new JSONObject(new JSONTokener(readBody(req)));
        } catch (Exception e) {
            writeError(res, 400, "Invalid JSON payload: " + e.getMessage());
            return;
        }
        if (!payload.has("value")) {
            writeError(res, 400, "Request body must contain a 'value' field");
            return;
        }

        try {
            datasetService.appendElement(nodeRef, field, payload.get("value"));
            res.setStatus(201);
            JSONObject result = new JSONObject();
            result.put("field", field);
            result.put("value", payload.get("value"));
            writeJson(res, result.toString());
        } catch (InvalidNodeRefException e) {
            writeError(res, 404, "Dataset not found: " + name);
        } catch (IllegalArgumentException e) {
            writeError(res, 400, "Cannot append to field '" + field + "': " + e.getMessage());
        } catch (Exception e) {
            writeError(res, 500, e.getMessage());
        }
    }
}
