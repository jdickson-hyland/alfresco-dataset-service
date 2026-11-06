package org.alfresco.datasetservice.webscript;

import org.alfresco.datasetservice.model.DatasetInfo;
import org.alfresco.datasetservice.service.DatasetService;
import org.alfresco.service.cmr.repository.InvalidNodeRefException;
import org.alfresco.service.cmr.repository.NodeRef;
import org.springframework.extensions.webscripts.WebScriptRequest;
import org.springframework.extensions.webscripts.WebScriptResponse;

import java.io.IOException;
import java.net.URLDecoder;

public class DatasetVersionGetWebScript extends AbstractDssWebScript {

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
        String rawLabel = req.getServiceMatch().getTemplateVars().get("label");
        if (rawLabel == null || rawLabel.isEmpty()) {
            writeError(res, 400, "Missing version label");
            return;
        }
        String label;
        try {
            label = URLDecoder.decode(rawLabel, "UTF-8");
        } catch (Exception e) {
            label = rawLabel;
        }
        try {
            DatasetInfo info = datasetService.getVersion(nodeRef, label);
            if (info == null) {
                writeError(res, 404, "Version '" + label + "' not found");
                return;
            }
            writeJson(res, info.toJson().toString());
        } catch (InvalidNodeRefException e) {
            writeError(res, 404, "Dataset not found: " + nodeRef);
        } catch (Exception e) {
            writeError(res, 500, e.getMessage());
        }
    }
}
