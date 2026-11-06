// Server-side controller: pre-load schema list for initial render (Schemas tab)
var connector = remote.connect("alfresco");
var result = connector.get("/alfresco/datasets?type=schema");

if (result.status.code == 200) {
    var data = JSON.parse(result);
    model.datasets = data.datasets || [];
    model.error = null;
} else {
    model.datasets = [];
    model.error = "Failed to load schemas (HTTP " + result.status.code + ")";
}
