package org.alfresco.datasetservice.webscript;

import org.springframework.extensions.webscripts.AbstractWebScript;
import org.springframework.extensions.webscripts.WebScriptRequest;
import org.springframework.extensions.webscripts.WebScriptResponse;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.Map;

abstract class AbstractDssWebScript extends AbstractWebScript {

    protected void writeJson(WebScriptResponse res, String json) throws IOException {
        res.setContentType("application/json");
        res.setContentEncoding("UTF-8");
        res.getWriter().write(json);
    }

    protected void writeError(WebScriptResponse res, int status, String message) throws IOException {
        res.setContentType("application/json");
        res.setContentEncoding("UTF-8");
        res.setStatus(status);
        res.getWriter().write("{\"error\":" + jsonString(message) + "}");
    }

    // The dataset name from the URL (URL-decoded); null if absent/blank
    protected String extractDatasetName(WebScriptRequest req) {
        Map<String, String> vars = req.getServiceMatch().getTemplateVars();
        String raw = vars.get("datasetName");
        if (raw == null || raw.isEmpty()) return null;
        try {
            return URLDecoder.decode(raw, "UTF-8");
        } catch (Exception e) {
            return raw;
        }
    }

    protected String readBody(WebScriptRequest req) throws IOException {
        return req.getContent().getContent();
    }

    // Ensures a schema document is named "<base>_schema.json" (idempotent).
    protected String toSchemaName(String name) {
        if (name == null) return null;
        String n = name.trim();
        if (n.isEmpty()) return n;
        if (n.endsWith("_schema.json")) return n;
        if (n.endsWith(".json")) n = n.substring(0, n.length() - 5);
        if (n.endsWith("_schema")) return n + ".json";
        return n + "_schema.json";
    }

    // Dot-notation field path addressing an element within a dataset (empty = whole document)
    protected String readField(WebScriptRequest req) {
        String field = req.getParameter("field");
        return field != null ? field : "";
    }

    // Produces a JSON-safe quoted string
    static String jsonString(String s) {
        if (s == null) return "null";
        return "\"" + s.replace("\\", "\\\\")
                       .replace("\"", "\\\"")
                       .replace("\n", "\\n")
                       .replace("\r", "\\r")
                       .replace("\t", "\\t") + "\"";
    }
}
