package org.alfresco.datasetservice.webscript;

import org.alfresco.datasetservice.model.DatasetInfo;
import org.alfresco.datasetservice.service.DatasetService;
import org.springframework.extensions.webscripts.WebScriptRequest;
import org.springframework.extensions.webscripts.WebScriptResponse;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.List;

public class DatasetsListWebScript extends AbstractDssWebScript {

    private DatasetService datasetService;

    public void setDatasetService(DatasetService datasetService) {
        this.datasetService = datasetService;
    }

    @Override
    public void execute(WebScriptRequest req, WebScriptResponse res) throws IOException {
        try {
            String type = req.getParameter("type");
            List<DatasetInfo> datasets;
            if ("schema".equalsIgnoreCase(type)) {
                datasets = datasetService.listSchemas();
            } else if ("instance".equalsIgnoreCase(type)) {
                datasets = datasetService.listInstances();
            } else {
                datasets = datasetService.listDatasets();
            }
            JSONArray arr = new JSONArray();
            for (DatasetInfo d : datasets) arr.put(d.toJson());
            JSONObject result = new JSONObject();
            result.put("datasets", arr);
            writeJson(res, result.toString());
        } catch (Exception e) {
            writeError(res, 500, e.getMessage());
        }
    }
}
