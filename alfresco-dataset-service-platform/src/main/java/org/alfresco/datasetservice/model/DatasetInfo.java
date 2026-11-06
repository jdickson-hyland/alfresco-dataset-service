package org.alfresco.datasetservice.model;

import org.json.JSONObject;

public class DatasetInfo {

    private final String name;
    private final String description;
    private final String jsonContent;
    private final String versionLabel;
    private final String modifier;
    private final String modified;

    // Set for dataset instances (not schemas): the schema they conform to and their record count.
    private String schema;
    private Integer recordCount;

    public DatasetInfo(String name, String description, String jsonContent,
                       String versionLabel, String modifier, String modified) {
        this.name = name;
        this.description = description;
        this.jsonContent = jsonContent;
        this.versionLabel = versionLabel;
        this.modifier = modifier;
        this.modified = modified;
    }

    public String getName()         { return name; }
    public String getDescription()  { return description; }
    public String getJsonContent()  { return jsonContent; }
    public String getVersionLabel() { return versionLabel; }
    public String getModifier()     { return modifier; }
    public String getModified()     { return modified; }

    public String getSchema()       { return schema; }
    public Integer getRecordCount() { return recordCount; }
    public void setSchema(String schema)            { this.schema = schema; }
    public void setRecordCount(Integer recordCount) { this.recordCount = recordCount; }

    public JSONObject toJson() {
        JSONObject obj = new JSONObject();
        obj.put("name", name != null ? name : "");
        obj.put("description", description != null ? description : "");
        obj.put("versionLabel", versionLabel != null ? versionLabel : "");
        obj.put("modifier", modifier != null ? modifier : "");
        obj.put("modified", modified != null ? modified : "");
        if (jsonContent != null) {
            obj.put("json", jsonContent);
        }
        if (schema != null) {
            obj.put("schema", schema);
        }
        if (recordCount != null) {
            obj.put("recordCount", recordCount.intValue());
        }
        return obj;
    }
}
