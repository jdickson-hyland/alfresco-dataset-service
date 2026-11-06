package org.alfresco.datasetservice.webscript;

import org.alfresco.datasetservice.model.VersionInfo;
import org.alfresco.datasetservice.service.DatasetService;
import org.alfresco.service.cmr.repository.InvalidNodeRefException;
import org.alfresco.service.cmr.repository.NodeRef;
import org.springframework.extensions.webscripts.WebScriptRequest;
import org.springframework.extensions.webscripts.WebScriptResponse;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.List;

public class DatasetVersionsWebScript extends AbstractDssWebScript {

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
        try {
            List<VersionInfo> versions = datasetService.getVersionHistory(nodeRef);
            JSONArray arr = new JSONArray();
            for (VersionInfo v : versions) arr.put(v.toJson());
            JSONObject result = new JSONObject();
            result.put("versions", arr);
            writeJson(res, result.toString());
        } catch (InvalidNodeRefException e) {
            writeError(res, 404, "Dataset not found: " + nodeRef);
        } catch (Exception e) {
            writeError(res, 500, e.getMessage());
        }
    }
}
