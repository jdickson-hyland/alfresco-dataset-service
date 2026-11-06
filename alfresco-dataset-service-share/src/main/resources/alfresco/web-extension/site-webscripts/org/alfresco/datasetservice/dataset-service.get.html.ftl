<style>
#sfm-root { font-family: Arial, sans-serif; padding: 20px; color: #333; }
#sfm-root h2 { margin: 0 0 16px 0; font-size: 20px; }
#sfm-root h3 { margin: 0 0 10px 0; font-size: 15px; }
#sfm-root h5 { margin: 0 0 6px 0; font-size: 12px; color: #555; font-weight: bold; }
#sfm-root table { border-collapse: collapse; width: 100%; }
#sfm-root th, #sfm-root td { border: 1px solid #ddd; padding: 7px 10px; text-align: left; font-size: 13px; }
#sfm-root th { background: #f0f0f0; font-weight: bold; }
#sfm-root tr:hover td { background: #fafafa; }
#sfm-root input[type=text], #sfm-root input[type=number], #sfm-root textarea, #sfm-root select {
    padding: 5px 7px; border: 1px solid #ccc; border-radius: 3px; font-size: 13px; box-sizing: border-box; }
#sfm-root label { display: block; margin-bottom: 8px; font-size: 13px; }
#sfm-root label span { display: inline-block; min-width: 110px; font-weight: bold; }
#sfm-msg { margin-bottom: 12px; padding: 8px 12px; border-radius: 4px; display: none; font-size: 13px; }
#sfm-msg.ok  { background: #dff0d8; border: 1px solid #3c763d; color: #3c763d; }
#sfm-msg.err { background: #f2dede; border: 1px solid #a94442; color: #a94442; }
.sfm-btn { padding: 5px 12px; border: none; border-radius: 3px; cursor: pointer; margin: 2px; font-size: 12px; }
.sfm-btn-primary   { background: #0070c0; color: #fff; }
.sfm-btn-primary:hover { background: #005a9e; }
.sfm-btn-success   { background: #5cb85c; color: #fff; }
.sfm-btn-success:hover { background: #449d44; }
.sfm-btn-danger    { background: #d9534f; color: #fff; }
.sfm-btn-danger:hover  { background: #c9302c; }
.sfm-btn-default   { background: #888; color: #fff; }
.sfm-btn-default:hover { background: #666; }
.sfm-btn-sm { padding: 2px 7px; font-size: 11px; }

/* Editor */
#sfm-editor-view { margin-top: 8px; }
#sfm-meta { border: 1px solid #ddd; border-radius: 4px; padding: 12px; margin-bottom: 12px; background: #fafafa; }
#sfm-editor-actions { margin-top: 12px; display: flex; gap: 6px; }

/* JSON tree */
#sfm-tree { border: 1px solid #ddd; border-radius: 4px; padding: 10px; background: #fff; }
.sfm-node { border: 1px solid #cdd7e0; border-radius: 4px; margin: 6px 0; }
.sfm-node-header { background: #f0f4f8; padding: 5px 8px; display: flex; align-items: center; gap: 6px; border-radius: 4px 4px 0 0; }
.sfm-node-body { padding: 8px 8px 8px 20px; display: block; border-top: 1px solid #e0e6ec; }
.sfm-node-body.collapsed { display: none; }
.sfm-field-row { display: flex; align-items: center; gap: 6px; padding: 3px 0; }
.sfm-key-input { width: 180px; font-family: monospace; }
.sfm-index-label { width: 46px; font-family: monospace; color: #888; font-size: 12px; flex-shrink: 0; }
.sfm-type-select { width: 92px; flex-shrink: 0; }
.sfm-value-input { flex: 1; min-width: 80px; }
.sfm-type-badge { font-size: 10px; padding: 1px 6px; border-radius: 8px; background: #d0e8ff; color: #0070c0; flex-shrink: 0; }
.sfm-collapse-arrow { cursor: pointer; font-size: 10px; width: 12px; flex-shrink: 0; transition: transform 0.15s; }
.sfm-collapse-arrow.collapsed { transform: rotate(-90deg); }
.sfm-add-row { padding: 4px 0 0 0; }
#sfm-raw-area { width: 100%; height: 420px; font-family: monospace; font-size: 12px; padding: 6px;
    border: 1px solid #ccc; border-radius: 3px; resize: vertical; box-sizing: border-box; }

/* Version overlay */
#sfm-versions-overlay { position: fixed; top:0; left:0; right:0; bottom:0;
    background: rgba(0,0,0,0.45); z-index: 2000; display: none; align-items: center; justify-content: center; }
#sfm-versions-overlay.open { display: flex; }
#sfm-versions-panel { background: #fff; border-radius: 6px; padding: 24px;
    max-width: 720px; width: 92%; max-height: 80vh; overflow-y: auto; box-shadow: 0 6px 24px rgba(0,0,0,0.25); }
#sfm-version-content-area { width: 100%; height: 200px; font-family: monospace; font-size: 12px;
    border: 1px solid #ccc; border-radius: 3px; padding: 6px; resize: vertical; margin-top: 8px; }
.sfm-loading { color: #888; font-size: 12px; font-style: italic; padding: 6px; }

/* Tabs */
.sfm-tabs { display:flex; gap:4px; border-bottom:2px solid #ddd; margin-bottom:16px; }
.sfm-tabs button { border:none; background:none; padding:8px 16px; font-size:14px; cursor:pointer;
    color:#555; border-bottom:2px solid transparent; margin-bottom:-2px; }
.sfm-tabs button.active { color:#0070c0; border-bottom-color:#0070c0; font-weight:bold; }

/* Dataset instance editor */
#dsi-meta { border:1px solid #ddd; border-radius:4px; padding:12px; margin-bottom:12px; background:#fafafa; }
#dsi-records-toolbar { display:flex; align-items:center; gap:8px; margin:10px 0; flex-wrap:wrap; }
.dsi-empty { color:#888; font-size:13px; font-style:italic; padding:10px 2px; }
.dsi-cell-complex { color:#999; font-family:monospace; font-size:12px; }
.dsi-query-note { color:#0070c0; font-size:12px; margin:6px 0; }

/* Record form overlay */
#dsi-record-overlay { position:fixed; top:0; left:0; right:0; bottom:0; background:rgba(0,0,0,0.45);
    z-index:2100; display:none; align-items:center; justify-content:center; }
#dsi-record-overlay.open { display:flex; }
#dsi-record-panel { background:#fff; border-radius:6px; padding:24px; max-width:620px; width:92%;
    max-height:85vh; overflow-y:auto; box-shadow:0 6px 24px rgba(0,0,0,0.25); }
#dsi-record-form .dsi-field { margin-bottom:10px; }
#dsi-record-form label.dsi-lbl { display:block; font-weight:bold; font-size:12px; margin-bottom:3px; color:#444; }
#dsi-record-form fieldset { border:1px solid #cdd7e0; border-radius:4px; margin:8px 0; padding:8px 10px; }
#dsi-record-form legend { font-size:12px; font-weight:bold; color:#0070c0; padding:0 4px; }
#dsi-record-form input[type=text], #dsi-record-form input[type=number] { width:100%; }
#dsi-record-actions { margin-top:14px; display:flex; gap:6px; }
.dsi-arr-item { display:flex; gap:6px; align-items:flex-start; margin-bottom:6px; }
.dsi-arr-item > .dsi-arr-body { flex:1; }
</style>

<div id="sfm-root">
    <h2>Dataset Manager</h2>
    <div id="sfm-msg"></div>

    <div class="sfm-tabs">
        <button id="sfm-tab-schemas" class="active" onclick="SFM.setTab('schemas')">Schemas</button>
        <button id="sfm-tab-datasets" onclick="SFM.setTab('datasets')">Datasets</button>
    </div>

    <!-- ========================= SCHEMAS TAB ========================= -->
    <div id="sfm-schemas-section">

    <!-- ===== View 1: Schema List ===== -->
    <div id="sfm-list-view">
        <div style="margin-bottom:10px">
            <button class="sfm-btn sfm-btn-primary" onclick="SFM.showCreateView()">+ Create New Schema</button>
        </div>
        <#if error??>
            <div id="sfm-msg" class="err" style="display:block">${error}</div>
        </#if>
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Version</th>
                    <th>Modified</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="sfm-datasets-body">
                <#list datasets as d>
                <tr>
                    <td><strong>${d.name!''}</strong></td>
                    <td>${d.description!''}</td>
                    <td>${d.versionLabel!''}</td>
                    <td>${d.modified!''}</td>
                    <td>
                        <button class="sfm-btn sfm-btn-primary sfm-btn-sm"
                            onclick="SFM.editDataset('${d.name?js_string}')">Edit</button>
                        <button class="sfm-btn sfm-btn-default sfm-btn-sm"
                            onclick="SFM.showVersions('${d.name?js_string}')">Versions</button>
                        <button class="sfm-btn sfm-btn-danger sfm-btn-sm"
                            onclick="SFM.deleteDataset('${d.name?js_string}')">Delete</button>
                    </td>
                </tr>
                </#list>
                <#if !datasets?has_content>
                <tr id="sfm-empty-row"><td colspan="5" style="text-align:center;color:#888;">No schemas yet. Click "Create New Schema" to get started.</td></tr>
                </#if>
            </tbody>
        </table>
    </div>

    <!-- ===== View 2: Dataset Editor ===== -->
    <div id="sfm-editor-view" style="display:none">
        <div style="margin-bottom:10px;display:flex;align-items:center;gap:10px">
            <h3 id="sfm-editor-title" style="margin:0">New Schema</h3>
            <button class="sfm-btn sfm-btn-default sfm-btn-sm" onclick="SFM.showListView()">&larr; Back to List</button>
        </div>
        <div id="sfm-meta">
            <label><span>Name *</span><input type="text" id="sfm-ds-name" style="width:320px" placeholder="e.g. clients"/>
                <span style="margin-left:8px;color:#888;font-size:12px;font-weight:normal">saved as &lt;name&gt;_schema.json</span></label>
            <label><span>Description</span><input type="text" id="sfm-ds-desc" style="width:320px" placeholder="Optional description"/></label>
        </div>

        <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:6px">
            <h3 style="margin:0">Data</h3>
            <button class="sfm-btn sfm-btn-default sfm-btn-sm" id="sfm-raw-toggle" onclick="SFM.toggleRaw()">Edit raw JSON</button>
        </div>
        <div id="sfm-tree"></div>
        <textarea id="sfm-raw-area" style="display:none" spellcheck="false"></textarea>

        <div id="sfm-editor-actions">
            <button class="sfm-btn sfm-btn-primary" onclick="SFM.saveDataset()">Save Schema</button>
            <button class="sfm-btn sfm-btn-default" onclick="SFM.showListView()">Cancel</button>
        </div>
    </div>
    </div><!-- /sfm-schemas-section -->

    <!-- ========================= DATASETS TAB ========================= -->
    <div id="sfm-datasets-section" style="display:none">

        <!-- Instance list -->
        <div id="dsi-list-view">
            <div style="margin-bottom:10px">
                <button class="sfm-btn sfm-btn-primary" onclick="SFM.showInstanceCreate()">+ Create New Dataset</button>
            </div>
            <table>
                <thead><tr><th>Name</th><th>Schema</th><th>Records</th><th>Modified</th><th>Actions</th></tr></thead>
                <tbody id="dsi-list-body">
                    <tr><td colspan="5" style="text-align:center;color:#888;">Loading&hellip;</td></tr>
                </tbody>
            </table>
        </div>

        <!-- Instance editor -->
        <div id="dsi-editor-view" style="display:none">
            <div style="margin-bottom:10px;display:flex;align-items:center;gap:10px">
                <h3 id="dsi-editor-title" style="margin:0">New Dataset</h3>
                <button class="sfm-btn sfm-btn-default sfm-btn-sm" onclick="SFM.showInstanceList()">&larr; Back to List</button>
            </div>
            <div id="dsi-meta">
                <label><span>Name *</span><input type="text" id="dsi-name" style="width:320px" placeholder="e.g. clients-eu"/></label>
                <label><span>Description</span><input type="text" id="dsi-desc" style="width:320px" placeholder="Optional description"/></label>
                <label><span>Schema *</span><select id="dsi-schema" style="width:320px" onchange="SFM.onSchemaChange()"></select></label>
            </div>

            <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:6px">
                <h3 style="margin:0">Records</h3>
                <button class="sfm-btn sfm-btn-success sfm-btn-sm" onclick="SFM.addRecord()">+ Add Record</button>
            </div>
            <div id="dsi-records-toolbar">
                <span style="font-weight:bold">Filter via REST:</span>
                <input type="text" id="dsi-q-field" placeholder="field" style="width:120px"/>
                <input type="text" id="dsi-q-value" placeholder="value" style="width:120px"/>
                <button class="sfm-btn sfm-btn-default sfm-btn-sm" onclick="SFM.queryRecords()">Query</button>
                <button class="sfm-btn sfm-btn-default sfm-btn-sm" onclick="SFM.clearQuery()">Show all</button>
            </div>
            <div id="dsi-records"></div>

            <div style="margin-top:12px;display:flex;gap:6px">
                <button class="sfm-btn sfm-btn-primary" onclick="SFM.saveInstance()">Save Dataset</button>
                <button class="sfm-btn sfm-btn-default" onclick="SFM.showInstanceList()">Cancel</button>
            </div>
        </div>
    </div><!-- /sfm-datasets-section -->

    <!-- ===== View 3: Version History Overlay ===== -->
    <div id="sfm-versions-overlay">
        <div id="sfm-versions-panel">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:12px">
                <h3 style="margin:0">Version History</h3>
                <button class="sfm-btn sfm-btn-default sfm-btn-sm" onclick="SFM.closeVersionsPanel()">Close</button>
            </div>
            <div id="sfm-versions-content"><div class="sfm-loading">Loading&hellip;</div></div>
        </div>
    </div>

    <!-- ===== Record Form Overlay (schema-driven) ===== -->
    <div id="dsi-record-overlay">
        <div id="dsi-record-panel">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:12px">
                <h3 id="dsi-record-title" style="margin:0">Record</h3>
                <button class="sfm-btn sfm-btn-default sfm-btn-sm" onclick="SFM.cancelRecord()">Close</button>
            </div>
            <div id="dsi-record-form"></div>
            <div id="dsi-record-actions">
                <button class="sfm-btn sfm-btn-primary" onclick="SFM.applyRecord()">Apply</button>
                <button class="sfm-btn sfm-btn-default" onclick="SFM.cancelRecord()">Cancel</button>
            </div>
        </div>
    </div>
</div>

<script>
(function() {
    var PROXY = Alfresco.constants.PROXY_URI + "alfresco/datasets";

    var state = {
        currentName: null,   // schema being edited, or null when creating
        data: {},            // the live JSON document model (root object)
        rawMode: false,
        versionsName: null,
        // ----- Datasets tab (instances) -----
        tab: "schemas",
        instOriginalName: null,  // instance being edited, or null when creating
        instSchema: null,        // schema name the instance conforms to
        schemaTemplate: {},      // the chosen schema's template object (drives the record form)
        records: [],             // in-memory record list for the instance being edited
        recordDraft: null,       // record object currently open in the form
        recordIndex: -1          // index being edited, or -1 for a new record
    };

    // ────────────────────────────── Utilities ──────────────────────────────

    function apiCall(method, path, body, callback) {
        var xhr = new XMLHttpRequest();
        xhr.open(method, PROXY + path, true);
        xhr.setRequestHeader("Content-Type", "application/json");
        xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
        xhr.onload = function() {
            var data = null;
            try { data = JSON.parse(xhr.responseText); } catch(e) {}
            callback(xhr.status, data, xhr.responseText);
        };
        xhr.onerror = function() { callback(0, null, ""); };
        xhr.send(body ? JSON.stringify(body) : null);
    }

    function showMsg(text, isError) {
        var el = document.getElementById("sfm-msg");
        el.textContent = text;
        el.className = isError ? "err" : "ok";
        el.style.display = "block";
        if (!isError) setTimeout(function() { el.style.display = "none"; }, 4000);
    }

    // Builds the REST path for a dataset addressed by name
    function dsPath(name) { return "/" + encodeURIComponent(name); }

    function esc(s) {
        if (s === null || s === undefined) return "";
        return String(s).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/"/g,"&quot;");
    }

    function typeOf(v) {
        if (v === null) return "null";
        if (Array.isArray(v)) return "array";
        if (typeof v === "object") return "object";
        return typeof v; // string | number | boolean
    }

    function defaultForType(t) {
        switch (t) {
            case "number":  return 0;
            case "boolean": return false;
            case "null":    return null;
            case "object":  return {};
            case "array":   return [];
            default:        return "";
        }
    }

    function coerce(v, t) {
        switch (t) {
            case "string":  return (v === null || v === undefined) ? "" : String(v);
            case "number":  { var n = Number(v); return isNaN(n) ? 0 : n; }
            case "boolean": return (v === true || v === "true");
            case "null":    return null;
            case "object":  return (v && typeof v === "object" && !Array.isArray(v)) ? v : {};
            case "array":   return Array.isArray(v) ? v : [];
            default:        return "";
        }
    }

    function uniqueKey(obj, base) {
        if (!(base in obj)) return base;
        var i = 2;
        while ((base + i) in obj) i++;
        return base + i;
    }

    // ────────────────────────────── View switching ──────────────────────────────

    function showListView() {
        document.getElementById("sfm-list-view").style.display = "";
        document.getElementById("sfm-editor-view").style.display = "none";
    }

    function showEditorView(title) {
        document.getElementById("sfm-list-view").style.display = "none";
        document.getElementById("sfm-editor-view").style.display = "";
        document.getElementById("sfm-editor-title").textContent = title;
    }

    // ────────────────────────────── Dataset list ──────────────────────────────

    function loadDatasets() {
        apiCall("GET", "?type=schema", null, function(status, data) {
            if (status === 200) {
                renderDatasetTable(data.datasets || []);
            } else {
                showMsg("Failed to reload schemas", true);
            }
        });
    }

    function renderDatasetTable(datasets) {
        var tbody = document.getElementById("sfm-datasets-body");
        tbody.innerHTML = "";
        if (!datasets.length) {
            var row = document.createElement("tr");
            row.innerHTML = '<td colspan="5" style="text-align:center;color:#888;">No datasets yet. Click "Create New Dataset" to get started.</td>';
            tbody.appendChild(row);
            return;
        }
        datasets.forEach(function(d) {
            var tr = document.createElement("tr");
            tr.innerHTML =
                '<td><strong>' + esc(d.name) + '</strong></td>' +
                '<td>' + esc(d.description) + '</td>' +
                '<td>' + esc(d.versionLabel) + '</td>' +
                '<td>' + esc(d.modified) + '</td>' +
                '<td></td>';
            var cell = tr.cells[4];
            cell.appendChild(makeBtn("Edit", "sfm-btn-primary", function() {
                editDataset(d.name);
            }));
            cell.appendChild(makeBtn("Versions", "sfm-btn-default", function() {
                showVersions(d.name);
            }));
            cell.appendChild(makeBtn("Delete", "sfm-btn-danger", function() {
                deleteDataset(d.name);
            }));
            tbody.appendChild(tr);
        });
    }

    function makeBtn(label, cls, handler) {
        var btn = document.createElement("button");
        btn.textContent = label;
        btn.className = "sfm-btn " + cls + " sfm-btn-sm";
        btn.onclick = handler;
        return btn;
    }

    function deleteDataset(name) {
        if (!confirm('Delete dataset "' + name + '"? This cannot be undone.')) return;
        apiCall("DELETE", dsPath(name), null, function(s) {
            if (s === 200) { showMsg("Dataset deleted", false); loadDatasets(); }
            else showMsg("Delete failed", true);
        });
    }

    // ────────────────────────────── Create / edit ──────────────────────────────

    function showCreateView() {
        state.currentName = null;
        state.data = {};
        state.rawMode = false;
        document.getElementById("sfm-ds-name").value = "";
        document.getElementById("sfm-ds-desc").value = "";
        setRawVisible(false);
        renderTree();
        showEditorView("New Dataset");
    }

    function editDataset(name) {
        apiCall("GET", dsPath(name), null, function(s, d) {
            if (s !== 200 || !d) { showMsg("Failed to load dataset", true); return; }
            state.currentName = (d.name !== undefined ? d.name : name);
            state.rawMode = false;
            try { state.data = d.json ? JSON.parse(d.json) : {}; } catch(e) { state.data = {}; }
            if (typeOf(state.data) !== "object") { state.data = {}; }
            document.getElementById("sfm-ds-name").value = d.name || "";
            document.getElementById("sfm-ds-desc").value = d.description || "";
            setRawVisible(false);
            renderTree();
            showEditorView("Edit Dataset");
        });
    }

    function saveDataset() {
        var name = document.getElementById("sfm-ds-name").value.trim();
        if (!name) { showMsg("Dataset name is required", true); return; }

        var data;
        if (state.rawMode) {
            try { data = JSON.parse(document.getElementById("sfm-raw-area").value || "{}"); }
            catch(e) { showMsg("Raw JSON is invalid: " + e.message, true); return; }
        } else {
            data = state.data;
        }

        var desc = document.getElementById("sfm-ds-desc").value;
        var payload = { name: name, description: desc, data: data };

        if (state.currentName) {
            apiCall("PUT", dsPath(state.currentName), payload, function(s, d) {
                if (s === 200) { showMsg("Dataset saved", false); showListView(); loadDatasets(); }
                else showMsg((d && d.error) ? d.error : "Save failed", true);
            });
        } else {
            apiCall("POST", "", payload, function(s, d) {
                if (s === 201) {
                    showMsg("Dataset created", false);
                    if (d && d.name) state.currentName = d.name;
                    showListView(); loadDatasets();
                } else {
                    showMsg((d && d.error) ? d.error : "Create failed", true);
                }
            });
        }
    }

    // ────────────────────────────── Raw JSON toggle ──────────────────────────────

    function setRawVisible(raw) {
        state.rawMode = raw;
        document.getElementById("sfm-tree").style.display = raw ? "none" : "";
        document.getElementById("sfm-raw-area").style.display = raw ? "" : "none";
        document.getElementById("sfm-raw-toggle").textContent = raw ? "Edit as tree" : "Edit raw JSON";
    }

    function toggleRaw() {
        if (!state.rawMode) {
            // tree -> raw
            document.getElementById("sfm-raw-area").value = JSON.stringify(state.data, null, 2);
            setRawVisible(true);
        } else {
            // raw -> tree
            var parsed;
            try { parsed = JSON.parse(document.getElementById("sfm-raw-area").value || "{}"); }
            catch(e) { showMsg("Raw JSON is invalid: " + e.message, true); return; }
            if (typeOf(parsed) !== "object") { showMsg("The document root must be a JSON object", true); return; }
            state.data = parsed;
            setRawVisible(false);
            renderTree();
        }
    }

    // ────────────────────────────── JSON tree editor ──────────────────────────────

    function renderTree() {
        var root = document.getElementById("sfm-tree");
        root.innerHTML = "";
        renderContainer(root, state.data);
    }

    // Renders the entries of a container (object or array) plus its add-buttons row.
    function renderContainer(parentEl, container) {
        var isArray = Array.isArray(container);
        if (isArray) {
            container.forEach(function(_, i) { parentEl.appendChild(renderEntry(container, i, true)); });
        } else {
            Object.keys(container).forEach(function(k) { parentEl.appendChild(renderEntry(container, k, false)); });
        }
        parentEl.appendChild(renderAddRow(container, isArray));
    }

    function renderEntry(container, key, isArrayItem) {
        var value = container[key];
        var t = typeOf(value);
        return (t === "object" || t === "array")
            ? renderChildNode(container, key, isArrayItem, t)
            : renderFieldRow(container, key, isArrayItem, t);
    }

    function renderFieldRow(container, key, isArrayItem, t) {
        var row = document.createElement("div");
        row.className = "sfm-field-row";

        row.appendChild(keyCell(container, key, isArrayItem));
        row.appendChild(typeSelect(container, key, t));

        // value editor
        var value = container[key];
        if (t === "boolean") {
            var sel = document.createElement("select");
            sel.className = "sfm-value-input";
            sel.innerHTML = '<option value="true">true</option><option value="false">false</option>';
            sel.value = value ? "true" : "false";
            sel.onchange = function() { container[key] = (this.value === "true"); };
            row.appendChild(sel);
        } else if (t === "null") {
            var span = document.createElement("span");
            span.className = "sfm-value-input";
            span.style.color = "#999";
            span.textContent = "null";
            row.appendChild(span);
        } else {
            var inp = document.createElement("input");
            inp.type = (t === "number") ? "number" : "text";
            inp.className = "sfm-value-input";
            inp.value = value;
            inp.oninput = function() {
                container[key] = (t === "number")
                    ? (this.value === "" ? 0 : Number(this.value))
                    : this.value;
            };
            row.appendChild(inp);
        }

        row.appendChild(deleteBtn(container, key, isArrayItem));
        return row;
    }

    function renderChildNode(container, key, isArrayItem, t) {
        var node = document.createElement("div");
        node.className = "sfm-node";

        var header = document.createElement("div");
        header.className = "sfm-node-header";

        var arrow = document.createElement("span");
        arrow.className = "sfm-collapse-arrow";
        arrow.textContent = "▼";
        header.appendChild(arrow);

        header.appendChild(keyCell(container, key, isArrayItem));

        var badge = document.createElement("span");
        badge.className = "sfm-type-badge";
        badge.textContent = t;
        header.appendChild(badge);

        header.appendChild(typeSelect(container, key, t));
        header.appendChild(deleteBtn(container, key, isArrayItem));
        node.appendChild(header);

        var body = document.createElement("div");
        body.className = "sfm-node-body";
        renderContainer(body, container[key]);
        node.appendChild(body);

        arrow.onclick = function() {
            body.classList.toggle("collapsed");
            arrow.classList.toggle("collapsed");
        };

        return node;
    }

    // Key cell: editable input for object members, read-only index for array items.
    function keyCell(container, key, isArrayItem) {
        if (isArrayItem) {
            var label = document.createElement("span");
            label.className = "sfm-index-label";
            label.textContent = "[" + key + "]";
            return label;
        }
        var input = document.createElement("input");
        input.type = "text";
        input.className = "sfm-key-input";
        input.value = key;
        input.onchange = function() {
            var newKey = this.value.trim();
            if (!newKey || newKey === key) { this.value = key; return; }
            if (newKey in container) { showMsg('Field "' + newKey + '" already exists', true); this.value = key; return; }
            renameKey(container, key, newKey);
            renderTree();
        };
        return input;
    }

    function typeSelect(container, key, t) {
        var sel = document.createElement("select");
        sel.className = "sfm-type-select";
        ["string","number","boolean","null","object","array"].forEach(function(opt) {
            var o = document.createElement("option");
            o.value = opt; o.textContent = opt;
            sel.appendChild(o);
        });
        sel.value = t;
        sel.onchange = function() {
            container[key] = coerce(container[key], this.value);
            renderTree();
        };
        return sel;
    }

    function deleteBtn(container, key, isArrayItem) {
        var btn = document.createElement("button");
        btn.className = "sfm-btn sfm-btn-danger sfm-btn-sm";
        btn.textContent = "✕";
        btn.title = "Remove";
        btn.onclick = function() {
            if (isArrayItem) container.splice(key, 1);
            else delete container[key];
            renderTree();
        };
        return btn;
    }

    function renderAddRow(container, isArray) {
        var row = document.createElement("div");
        row.className = "sfm-add-row";
        if (isArray) {
            row.appendChild(addBtn("+ Value",  function() { container.push(""); renderTree(); }));
            row.appendChild(addBtn("+ Object",  function() { container.push({}); renderTree(); }));
            row.appendChild(addBtn("+ Array",   function() { container.push([]); renderTree(); }));
        } else {
            row.appendChild(addBtn("+ Field",       function() { container[uniqueKey(container, "field")] = ""; renderTree(); }));
            row.appendChild(addBtn("+ Child object", function() { container[uniqueKey(container, "node")]  = {}; renderTree(); }));
            row.appendChild(addBtn("+ Child array",  function() { container[uniqueKey(container, "items")] = []; renderTree(); }));
        }
        return row;
    }

    function addBtn(label, handler) {
        var btn = document.createElement("button");
        btn.className = "sfm-btn sfm-btn-default sfm-btn-sm";
        btn.textContent = label;
        btn.onclick = handler;
        return btn;
    }

    // Rename a key while preserving insertion order.
    function renameKey(container, oldKey, newKey) {
        var rebuilt = {};
        Object.keys(container).forEach(function(k) {
            rebuilt[k === oldKey ? newKey : k] = container[k];
        });
        Object.keys(container).forEach(function(k) { delete container[k]; });
        Object.keys(rebuilt).forEach(function(k) { container[k] = rebuilt[k]; });
    }

    // ────────────────────────────── Version history ──────────────────────────────

    function showVersions(name) {
        state.versionsName = name;
        var panel = document.getElementById("sfm-versions-content");
        panel.innerHTML = '<div class="sfm-loading">Loading&hellip;</div>';
        document.getElementById("sfm-versions-overlay").classList.add("open");

        apiCall("GET", dsPath(state.versionsName) + "/versions", null, function(s, data) {
            if (s !== 200) { panel.innerHTML = '<div style="color:#a94442">Failed to load versions</div>'; return; }
            var versions = data.versions || [];
            if (!versions.length) { panel.innerHTML = '<div class="sfm-loading">No version history</div>'; return; }

            var html = '<table style="width:100%"><thead><tr><th>Version</th><th>Modified</th><th>By</th><th>Notes</th><th></th></tr></thead><tbody>';
            versions.forEach(function(v) {
                html += '<tr><td>' + esc(v.versionLabel) + '</td><td>' + esc(v.modified) +
                    '</td><td>' + esc(v.modifier) + '</td><td>' + esc(v.description) + '</td><td>' +
                    '<button class="sfm-btn sfm-btn-primary sfm-btn-sm" onclick="SFM._viewVersion(\'' +
                    encodeURIComponent(v.versionLabel) + '\')">View</button> ' +
                    '<button class="sfm-btn sfm-btn-default sfm-btn-sm" onclick="SFM._restoreVersion(\'' +
                    encodeURIComponent(v.versionLabel) + '\')">Restore</button>' +
                    '</td></tr>';
            });
            html += '</tbody></table>';
            html += '<div id="sfm-version-json-area" style="display:none"><h5 style="margin-top:12px">Version Content:</h5>' +
                    '<textarea id="sfm-version-content-area" readonly></textarea></div>';
            panel.innerHTML = html;
        });
    }

    function _viewVersion(encodedLabel) {
        var area = document.getElementById("sfm-version-json-area");
        var ta = document.getElementById("sfm-version-content-area");
        if (!area || !ta) return;
        area.style.display = "block";
        ta.value = "Loading…";
        apiCall("GET", dsPath(state.versionsName) + "/versions/" + encodedLabel, null, function(s, d) {
            ta.value = (s === 200 && d && d.json) ? d.json : "Failed to load version content";
        });
    }

    function _restoreVersion(encodedLabel) {
        var label = decodeURIComponent(encodedLabel);
        if (!confirm("Restore version " + label + "? The current content will be overwritten.")) return;
        apiCall("GET", dsPath(state.versionsName) + "/versions/" + encodedLabel, null, function(s, d) {
            if (s !== 200 || !d || !d.json) { showMsg("Failed to load version for restore", true); return; }
            var data;
            try { data = JSON.parse(d.json); } catch(e) { data = d.json; }
            apiCall("PUT", dsPath(state.versionsName), { data: data, name: d.name, description: d.description }, function(ps) {
                if (ps === 200) {
                    showMsg("Version " + label + " restored", false);
                    closeVersionsPanel();
                    loadDatasets();
                } else {
                    showMsg("Restore failed", true);
                }
            });
        });
    }

    function closeVersionsPanel() {
        document.getElementById("sfm-versions-overlay").classList.remove("open");
    }

    // ══════════════════════════ Datasets tab (instances) ══════════════════════════

    function setTab(tab) {
        state.tab = tab;
        document.getElementById("sfm-tab-schemas").className = (tab === "schemas") ? "active" : "";
        document.getElementById("sfm-tab-datasets").className = (tab === "datasets") ? "active" : "";
        document.getElementById("sfm-schemas-section").style.display = (tab === "schemas") ? "" : "none";
        document.getElementById("sfm-datasets-section").style.display = (tab === "datasets") ? "" : "none";
        if (tab === "datasets") { showInstanceList(); loadInstances(); }
        else { showListView(); }
    }

    // ───────────── instance list ─────────────

    function loadInstances() {
        apiCall("GET", "?type=instance", null, function(status, data) {
            if (status === 200) renderInstanceTable(data.datasets || []);
            else showMsg("Failed to load datasets", true);
        });
    }

    function renderInstanceTable(list) {
        var tbody = document.getElementById("dsi-list-body");
        tbody.innerHTML = "";
        if (!list.length) {
            var tr0 = document.createElement("tr");
            tr0.innerHTML = '<td colspan="5" style="text-align:center;color:#888;">No datasets yet. Click "Create New Dataset" to get started.</td>';
            tbody.appendChild(tr0);
            return;
        }
        list.forEach(function(d) {
            var tr = document.createElement("tr");
            tr.innerHTML =
                '<td><strong>' + esc(d.name) + '</strong></td>' +
                '<td>' + esc(d.schema) + '</td>' +
                '<td>' + esc(d.recordCount != null ? d.recordCount : "") + '</td>' +
                '<td>' + esc(d.modified) + '</td>' +
                '<td></td>';
            var cell = tr.cells[4];
            cell.appendChild(makeBtn("Edit", "sfm-btn-primary", function(){ editInstance(d.name); }));
            cell.appendChild(makeBtn("Versions", "sfm-btn-default", function(){ showVersions(d.name); }));
            cell.appendChild(makeBtn("Delete", "sfm-btn-danger", function(){ deleteInstance(d.name); }));
            tbody.appendChild(tr);
        });
    }

    function showInstanceList() {
        document.getElementById("dsi-list-view").style.display = "";
        document.getElementById("dsi-editor-view").style.display = "none";
    }

    function showInstanceEditor(title) {
        document.getElementById("dsi-list-view").style.display = "none";
        document.getElementById("dsi-editor-view").style.display = "";
        document.getElementById("dsi-editor-title").textContent = title;
    }

    function deleteInstance(name) {
        if (!confirm('Delete dataset "' + name + '"? This cannot be undone.')) return;
        apiCall("DELETE", dsPath(name), null, function(s) {
            if (s === 200) { showMsg("Dataset deleted", false); loadInstances(); }
            else showMsg("Delete failed", true);
        });
    }

    // ───────────── create / edit instance ─────────────

    // Populate the schema <select>; invoke cb(selectedSchemaName|null) when done.
    function loadSchemaOptions(selected, cb) {
        apiCall("GET", "?type=schema", null, function(s, data) {
            var sel = document.getElementById("dsi-schema");
            sel.innerHTML = "";
            var schemas = (s === 200 && data) ? (data.datasets || []) : [];
            if (!schemas.length) {
                var o = document.createElement("option");
                o.value = ""; o.textContent = "(no schemas — create one first)";
                sel.appendChild(o);
                cb(null); return;
            }
            schemas.forEach(function(d) {
                var opt = document.createElement("option");
                opt.value = d.name; opt.textContent = d.name;
                sel.appendChild(opt);
            });
            sel.value = (selected && schemas.some(function(d){ return d.name === selected; })) ? selected : schemas[0].name;
            cb(sel.value);
        });
    }

    // Fetch a schema's template object into state.schemaTemplate; cb() when ready.
    function loadSchemaTemplate(schemaName, cb) {
        state.instSchema = schemaName;
        if (!schemaName) { state.schemaTemplate = {}; if (cb) cb(); return; }
        apiCall("GET", dsPath(schemaName), null, function(s, d) {
            var tmpl = {};
            if (s === 200 && d && d.json) { try { tmpl = JSON.parse(d.json); } catch(e) { tmpl = {}; } }
            if (typeOf(tmpl) !== "object") tmpl = {};
            state.schemaTemplate = tmpl;
            if (cb) cb();
        });
    }

    function onSchemaChange() {
        loadSchemaTemplate(document.getElementById("dsi-schema").value, function(){ renderRecordsTable(); });
    }

    function showInstanceCreate() {
        state.instOriginalName = null;
        state.records = [];
        document.getElementById("dsi-name").value = "";
        document.getElementById("dsi-desc").value = "";
        clearQueryInputs();
        showInstanceEditor("New Dataset");
        loadSchemaOptions(null, function(first){
            loadSchemaTemplate(first, function(){ renderRecordsTable(); });
        });
    }

    function editInstance(name) {
        apiCall("GET", dsPath(name), null, function(s, d) {
            if (s !== 200 || !d) { showMsg("Failed to load dataset", true); return; }
            var content = {};
            try { content = d.json ? JSON.parse(d.json) : {}; } catch(e) { content = {}; }
            state.instOriginalName = d.name;
            state.records = Array.isArray(content.records) ? content.records : [];
            document.getElementById("dsi-name").value = d.name || "";
            document.getElementById("dsi-desc").value = d.description || "";
            clearQueryInputs();
            showInstanceEditor("Edit Dataset");
            loadSchemaOptions(content.schema, function(sel){
                loadSchemaTemplate(content.schema || sel, function(){ renderRecordsTable(); });
            });
        });
    }

    function saveInstance() {
        var name = document.getElementById("dsi-name").value.trim();
        var schema = document.getElementById("dsi-schema").value;
        var desc = document.getElementById("dsi-desc").value;
        if (!name) { showMsg("Dataset name is required", true); return; }
        if (!schema) { showMsg("Choose a schema", true); return; }

        if (state.instOriginalName) {
            var putBody = { name: name, description: desc, data: { schema: schema, records: state.records } };
            apiCall("PUT", dsPath(state.instOriginalName), putBody, function(s, d) {
                if (s === 200) { showMsg("Dataset saved", false); showInstanceList(); loadInstances(); }
                else showMsg((d && d.error) ? d.error : "Save failed", true);
            });
        } else {
            var postBody = { name: name, description: desc, schema: schema, records: state.records };
            apiCall("POST", "", postBody, function(s, d) {
                if (s === 201) { showMsg("Dataset created", false); showInstanceList(); loadInstances(); }
                else showMsg((d && d.error) ? d.error : "Create failed", true);
            });
        }
    }

    // ───────────── records table ─────────────

    function dsiCell(v) {
        var t = typeOf(v);
        if (v === undefined || v === null) return '<span class="dsi-cell-complex">—</span>';
        if (t === "object") return '<span class="dsi-cell-complex">{…}</span>';
        if (t === "array")  return '<span class="dsi-cell-complex">[' + v.length + ']</span>';
        return esc(v);
    }

    function recordColumns(records) {
        var cols = [];
        Object.keys(state.schemaTemplate).forEach(function(k){ cols.push(k); });
        records.forEach(function(r){
            if (r && typeof r === "object") Object.keys(r).forEach(function(k){ if (cols.indexOf(k) === -1) cols.push(k); });
        });
        return cols;
    }

    // Editable in-memory table (default), or a read-only query-result set when readOnly is true.
    function renderRecordsTable(resultRecords, readOnly) {
        var records = readOnly ? resultRecords : state.records;
        var host = document.getElementById("dsi-records");
        host.innerHTML = "";

        if (readOnly) {
            var qnote = document.createElement("div");
            qnote.className = "dsi-query-note";
            qnote.textContent = "Query result: " + records.length + ' record(s). Click "Show all" to edit.';
            host.appendChild(qnote);
        }

        if (!records.length) {
            var empty = document.createElement("div");
            empty.className = "dsi-empty";
            empty.textContent = readOnly ? "No matching records." : 'No records yet. Click "+ Add Record" to create one.';
            host.appendChild(empty);
            return;
        }

        var cols = recordColumns(records);
        var table = document.createElement("table");
        var thead = "<thead><tr>";
        cols.forEach(function(c){ thead += "<th>" + esc(c) + "</th>"; });
        if (!readOnly) thead += "<th>Actions</th>";
        thead += "</tr></thead>";
        table.innerHTML = thead;

        var tbody = document.createElement("tbody");
        records.forEach(function(rec, i){
            var tr = document.createElement("tr");
            var html = "";
            cols.forEach(function(c){ html += "<td>" + dsiCell(rec ? rec[c] : undefined) + "</td>"; });
            if (!readOnly) html += "<td></td>";
            tr.innerHTML = html;
            if (!readOnly) {
                var cell = tr.cells[tr.cells.length - 1];
                cell.appendChild(makeBtn("Edit", "sfm-btn-primary", (function(idx){ return function(){ openRecordForm(idx); }; })(i)));
                cell.appendChild(makeBtn("Delete", "sfm-btn-danger", (function(idx){ return function(){ deleteRecord(idx); }; })(i)));
            }
            tbody.appendChild(tr);
        });
        table.appendChild(tbody);
        host.appendChild(table);
    }

    function deleteRecord(index) {
        if (!confirm("Delete record #" + index + "?")) return;
        state.records.splice(index, 1);
        renderRecordsTable();
    }

    // ───────────── record form (generated from schema) ─────────────

    function addRecord() { openRecordForm(-1); }

    function openRecordForm(index) {
        var draft;
        if (index >= 0) {
            try { draft = JSON.parse(JSON.stringify(state.records[index])); } catch(e) { draft = {}; }
        } else {
            try { draft = JSON.parse(JSON.stringify(state.schemaTemplate)); } catch(e) { draft = {}; }
        }
        if (typeOf(draft) !== "object") draft = {};
        state.recordDraft = draft;
        state.recordIndex = index;
        document.getElementById("dsi-record-title").textContent = (index >= 0 ? "Edit Record #" + index : "Add Record");
        renderRecordForm();
        document.getElementById("dsi-record-overlay").classList.add("open");
    }

    function renderRecordForm() {
        var host = document.getElementById("dsi-record-form");
        host.innerHTML = "";
        if (!Object.keys(state.schemaTemplate).length) {
            var note = document.createElement("div");
            note.className = "dsi-empty";
            note.textContent = "The selected schema has no fields.";
            host.appendChild(note);
            return;
        }
        buildFields(host, state.schemaTemplate, state.recordDraft);
    }

    // Walk the schema template, producing a typed input per field (recursing objects & arrays).
    function buildFields(container, template, obj) {
        Object.keys(template).forEach(function(key){
            var tval = template[key];
            var t = typeOf(tval);
            if (t === "object") {
                if (typeOf(obj[key]) !== "object") obj[key] = {};
                var fs = document.createElement("fieldset");
                var lg = document.createElement("legend"); lg.textContent = key; fs.appendChild(lg);
                buildFields(fs, tval, obj[key]);
                container.appendChild(fs);
            } else if (t === "array") {
                container.appendChild(buildArrayField(key, tval, obj));
            } else {
                container.appendChild(buildScalarField(key, tval, obj, key));
            }
        });
    }

    function buildScalarField(labelText, tval, obj, key) {
        var wrap = document.createElement("div");
        wrap.className = "dsi-field";
        var lbl = document.createElement("label");
        lbl.className = "dsi-lbl";
        lbl.textContent = labelText;
        wrap.appendChild(lbl);

        var t = typeOf(tval);
        if (t === "boolean") {
            var cb = document.createElement("input");
            cb.type = "checkbox";
            cb.checked = (obj[key] === true);
            cb.onchange = function(){ obj[key] = this.checked; };
            wrap.appendChild(cb);
        } else {
            var inp = document.createElement("input");
            inp.type = (t === "number") ? "number" : "text";
            inp.value = (obj[key] !== undefined && obj[key] !== null && typeOf(obj[key]) !== "object") ? obj[key] : "";
            inp.oninput = function(){
                obj[key] = (t === "number") ? (this.value === "" ? 0 : Number(this.value)) : this.value;
            };
            wrap.appendChild(inp);
        }
        return wrap;
    }

    // Array field: repeatable items of the element type (from template[0], default "").
    function buildArrayField(key, tval, obj) {
        if (!Array.isArray(obj[key])) obj[key] = [];
        var arr = obj[key];
        var elemTemplate = (tval.length ? tval[0] : "");
        var elemType = typeOf(elemTemplate);

        var fs = document.createElement("fieldset");
        var lg = document.createElement("legend"); lg.textContent = key + " [" + arr.length + "]"; fs.appendChild(lg);

        arr.forEach(function(item, idx){
            var row = document.createElement("div");
            row.className = "dsi-arr-item";
            var body = document.createElement("div");
            body.className = "dsi-arr-body";
            if (elemType === "object") {
                if (typeOf(arr[idx]) !== "object") arr[idx] = {};
                buildFields(body, elemTemplate, arr[idx]);
            } else {
                var inp = document.createElement("input");
                inp.type = (elemType === "number") ? "number" : "text";
                inp.value = (item !== undefined && item !== null && typeOf(item) !== "object") ? item : "";
                inp.oninput = (function(i){ return function(){ arr[i] = (elemType === "number") ? (this.value === "" ? 0 : Number(this.value)) : this.value; }; })(idx);
                body.appendChild(inp);
            }
            row.appendChild(body);
            row.appendChild(makeBtn("✕", "sfm-btn-danger", (function(i){ return function(){ arr.splice(i, 1); renderRecordForm(); }; })(idx)));
            fs.appendChild(row);
        });

        fs.appendChild(makeBtn("+ Add item", "sfm-btn-default", function(){
            var clone;
            try { clone = JSON.parse(JSON.stringify(elemTemplate)); }
            catch(e) { clone = (elemType === "number") ? 0 : (elemType === "boolean" ? false : ""); }
            arr.push(clone);
            renderRecordForm();
        }));
        return fs;
    }

    function applyRecord() {
        if (!state.recordDraft) return;
        if (state.recordIndex >= 0) state.records[state.recordIndex] = state.recordDraft;
        else state.records.push(state.recordDraft);
        closeRecordForm();
        renderRecordsTable();
    }

    function cancelRecord() { closeRecordForm(); }

    function closeRecordForm() {
        document.getElementById("dsi-record-overlay").classList.remove("open");
        state.recordDraft = null;
        state.recordIndex = -1;
    }

    // ───────────── REST query (filter) ─────────────

    function clearQueryInputs() {
        document.getElementById("dsi-q-field").value = "";
        document.getElementById("dsi-q-value").value = "";
    }

    function queryRecords() {
        if (!state.instOriginalName) { showMsg("Save the dataset first, then query it via REST", true); return; }
        var field = document.getElementById("dsi-q-field").value.trim();
        var value = document.getElementById("dsi-q-value").value;
        if (!field) { clearQuery(); return; }
        var path = dsPath(state.instOriginalName) + "/records?" + encodeURIComponent(field) + "=" + encodeURIComponent(value);
        apiCall("GET", path, null, function(s, d) {
            if (s !== 200 || !d) { showMsg("Query failed", true); return; }
            renderRecordsTable(d.records || [], true);
        });
    }

    function clearQuery() {
        clearQueryInputs();
        renderRecordsTable();
    }

    // ────────────────────────────── Public API ──────────────────────────────
    window.SFM = {
        showCreateView:     showCreateView,
        showListView:       showListView,
        editDataset:        editDataset,
        saveDataset:        saveDataset,
        deleteDataset:      deleteDataset,
        toggleRaw:          toggleRaw,
        showVersions:       showVersions,
        closeVersionsPanel: closeVersionsPanel,
        _viewVersion:       _viewVersion,
        _restoreVersion:    _restoreVersion,
        // Datasets tab
        setTab:             setTab,
        showInstanceCreate: showInstanceCreate,
        showInstanceList:   showInstanceList,
        editInstance:       editInstance,
        deleteInstance:     deleteInstance,
        saveInstance:       saveInstance,
        onSchemaChange:     onSchemaChange,
        addRecord:          addRecord,
        applyRecord:        applyRecord,
        cancelRecord:       cancelRecord,
        queryRecords:       queryRecords,
        clearQuery:         clearQuery
    };
})();
</script>
