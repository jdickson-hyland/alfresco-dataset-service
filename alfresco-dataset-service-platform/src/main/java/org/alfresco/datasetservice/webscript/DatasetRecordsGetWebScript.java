package org.alfresco.datasetservice.webscript;

import org.alfresco.datasetservice.model.DatasetInfo;
import org.alfresco.datasetservice.service.DatasetService;
import org.alfresco.service.cmr.repository.NodeRef;
import org.springframework.extensions.webscripts.WebScriptRequest;
import org.springframework.extensions.webscripts.WebScriptResponse;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Queries the records of a dataset instance:
 * {@code GET /alfresco/datasets/{datasetName}/records[?field=value&...]}.
 * Returns all records, or those matching every supplied field=value filter (AND).
 * Reads the raw stored content and uses Jackson, so each record's field order is
 * preserved (matching the schema order).
 */
public class DatasetRecordsGetWebScript extends AbstractDssWebScript {

    // Query parameters that are framework/plumbing, not record-field filters.
    private static final Set<String> RESERVED =
        new HashSet<>(Arrays.asList("format", "alf_ticket", "guest"));

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

        // Read the raw stored content (order preserved) and locate the records array
        ArrayNode records;
        try {
            DatasetInfo info = datasetService.getDataset(nodeRef, true);
            String content = (info != null && info.getJsonContent() != null) ? info.getJsonContent() : "{}";
            JsonNode root = MAPPER.readTree(content.isEmpty() ? "{}" : content);
            JsonNode recordsNode = root.get("records");
            records = (recordsNode != null && recordsNode.isArray())
                ? (ArrayNode) recordsNode : MAPPER.createArrayNode();
        } catch (Exception e) {
            records = MAPPER.createArrayNode();
        }

        // Collect field=value filters from the query string
        ObjectNode filters = MAPPER.createObjectNode();
        for (String p : req.getParameterNames()) {
            if (!RESERVED.contains(p)) {
                filters.put(p, req.getParameter(p));
            }
        }

        ArrayNode matched = MAPPER.createArrayNode();
        for (JsonNode item : records) {
            if (item.isObject() && matches(item, filters)) {
                matched.add(item);
            }
        }

        ObjectNode result = MAPPER.createObjectNode();
        result.set("records", matched);
        result.put("count", matched.size());
        writeJson(res, MAPPER.writeValueAsString(result));
    }

    // A record matches when, for every filter, its field (as a string) equals the requested value.
    private boolean matches(JsonNode record, ObjectNode filters) {
        java.util.Iterator<String> names = filters.fieldNames();
        while (names.hasNext()) {
            String field = names.next();
            JsonNode actual = record.get(field);
            if (actual == null || actual.isNull() || !actual.asText().equals(filters.get(field).asText())) {
                return false;
            }
        }
        return true;
    }
}
