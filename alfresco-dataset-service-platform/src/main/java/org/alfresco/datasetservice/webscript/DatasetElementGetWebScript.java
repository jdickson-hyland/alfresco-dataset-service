package org.alfresco.datasetservice.webscript;

import org.alfresco.datasetservice.service.DatasetService;
import org.alfresco.service.cmr.repository.InvalidNodeRefException;
import org.alfresco.service.cmr.repository.NodeRef;
import org.springframework.extensions.webscripts.WebScriptRequest;
import org.springframework.extensions.webscripts.WebScriptResponse;
import org.json.JSONObject;

import java.io.IOException;

public class DatasetElementGetWebScript extends AbstractDssWebScript {

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
        try {
            Object value = datasetService.getElement(nodeRef, field);
            JSONObject result = new JSONObject();
            result.put("field", field);
            result.put("value", value);
            writeJson(res, result.toString());
        } catch (InvalidNodeRefException e) {
            writeError(res, 404, "Dataset not found: " + name);
        } catch (IllegalArgumentException e) {
            writeError(res, 404, "No value at field '" + field + "': " + e.getMessage());
        } catch (Exception e) {
            writeError(res, 500, e.getMessage());
        }
    }
}
