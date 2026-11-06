package org.alfresco.datasetservice.service;

import org.alfresco.datasetservice.model.DatasetInfo;
import org.alfresco.datasetservice.model.DssModel;
import org.alfresco.datasetservice.model.VersionInfo;
import org.alfresco.model.ContentModel;
import org.alfresco.repo.security.authentication.AuthenticationUtil;
import org.alfresco.repo.version.VersionModel;
import org.alfresco.service.cmr.repository.ChildAssociationRef;
import org.alfresco.service.cmr.repository.ContentReader;
import org.alfresco.service.cmr.repository.ContentService;
import org.alfresco.service.cmr.repository.ContentWriter;
import org.alfresco.service.cmr.repository.NodeRef;
import org.alfresco.service.cmr.repository.NodeService;
import org.alfresco.service.cmr.repository.StoreRef;
import org.alfresco.service.cmr.version.Version;
import org.alfresco.service.cmr.version.VersionHistory;
import org.alfresco.service.cmr.version.VersionService;
import org.alfresco.service.cmr.version.VersionType;
import org.alfresco.service.namespace.NamespaceService;
import org.alfresco.service.namespace.QName;
import org.alfresco.service.transaction.TransactionService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DatasetServiceImpl implements DatasetService {

    private static final String DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";

    private NodeService nodeService;
    private ContentService contentService;
    private VersionService versionService;
    private NamespaceService namespaceService;
    private TransactionService transactionService;

    public void setNodeService(NodeService nodeService)           { this.nodeService = nodeService; }
    public void setContentService(ContentService contentService)  { this.contentService = contentService; }
    public void setVersionService(VersionService versionService)  { this.versionService = versionService; }
    public void setNamespaceService(NamespaceService ns)          { this.namespaceService = ns; }
    public void setTransactionService(TransactionService ts)      { this.transactionService = ts; }

    // ===== whole-document CRUD =====

    @Override
    public NodeRef createDataset(String name, String description, String jsonContent) {
        validateName(name);
        return AuthenticationUtil.runAsSystem(() -> {
            NodeRef datasetsFolderRef = getOrCreateDatasetsFolder();

            Map<QName, Serializable> props = new HashMap<>();
            props.put(ContentModel.PROP_NAME, name);
            props.put(ContentModel.PROP_TITLE, name);
            props.put(ContentModel.PROP_DESCRIPTION, description != null ? description : "");

            QName assocName = QName.createQName(
                NamespaceService.CONTENT_MODEL_1_0_URI,
                QName.createValidLocalName(name)
            );
            ChildAssociationRef assoc = nodeService.createNode(
                datasetsFolderRef,
                ContentModel.ASSOC_CONTAINS,
                assocName,
                ContentModel.TYPE_CONTENT,
                props
            );
            NodeRef nodeRef = assoc.getChildRef();

            // Add versionable before first content write so version 1.0 is seeded
            Map<QName, Serializable> versionProps = new HashMap<>();
            versionProps.put(ContentModel.PROP_VERSION_TYPE, VersionType.MINOR);
            nodeService.addAspect(nodeRef, ContentModel.ASPECT_VERSIONABLE, versionProps);

            // Marker aspect so dataset files are reliably identifiable
            nodeService.addAspect(nodeRef, DssModel.ASPECT_DATASET, null);

            // Write JSON content
            ContentWriter writer = contentService.getWriter(nodeRef, ContentModel.PROP_CONTENT, true);
            writer.setMimetype("application/json");
            writer.setEncoding("UTF-8");
            writer.putContent(jsonContent != null && !jsonContent.trim().isEmpty() ? jsonContent : "{}");

            // Explicitly create version 1.0
            Map<String, Serializable> verProps = new HashMap<>();
            verProps.put(VersionModel.PROP_VERSION_TYPE, VersionType.MINOR);
            verProps.put(VersionModel.PROP_DESCRIPTION, "Initial version");
            versionService.createVersion(nodeRef, verProps);

            return nodeRef;
        });
    }

    @Override
    public NodeRef updateDataset(NodeRef nodeRef, String name, String description, String jsonContent) {
        validateName(name);
        return AuthenticationUtil.runAsSystem(() -> {
            if (name != null) {
                nodeService.setProperty(nodeRef, ContentModel.PROP_NAME, name);
                nodeService.setProperty(nodeRef, ContentModel.PROP_TITLE, name);
            }
            if (description != null) {
                nodeService.setProperty(nodeRef, ContentModel.PROP_DESCRIPTION, description);
            }

            // Writing new content triggers automatic versioning when cm:versionable is present
            if (jsonContent != null) {
                ContentWriter writer = contentService.getWriter(nodeRef, ContentModel.PROP_CONTENT, true);
                writer.setMimetype("application/json");
                writer.setEncoding("UTF-8");
                writer.putContent(jsonContent);
            }

            return nodeRef;
        });
    }

    @Override
    public List<DatasetInfo> listDatasets() {
        return list(ListFilter.ALL);
    }

    @Override
    public List<DatasetInfo> listSchemas() {
        return list(ListFilter.SCHEMA);
    }

    @Override
    public List<DatasetInfo> listInstances() {
        return list(ListFilter.INSTANCE);
    }

    private enum ListFilter { ALL, SCHEMA, INSTANCE }

    // Schema documents are named "<name>_schema.json"; instances carry a plain name.
    static boolean isSchemaName(String name) {
        return name != null && name.endsWith("_schema.json");
    }

    private List<DatasetInfo> list(ListFilter filter) {
        return AuthenticationUtil.runAsSystem(() -> {
            // Read-only: never create the folder here (this may run in a read-only transaction)
            NodeRef folder = getDatasetsFolder();
            if (folder == null) {
                return Collections.<DatasetInfo>emptyList();
            }
            List<ChildAssociationRef> children = nodeService.getChildAssocs(folder);
            List<DatasetInfo> result = new ArrayList<>();
            for (ChildAssociationRef child : children) {
                NodeRef ref = child.getChildRef();
                String name = (String) nodeService.getProperty(ref, ContentModel.PROP_NAME);
                boolean schema = isSchemaName(name);
                if (filter == ListFilter.SCHEMA && !schema) continue;
                if (filter == ListFilter.INSTANCE && schema) continue;

                DatasetInfo info = buildDatasetInfo(ref, false);
                if (!schema) {
                    // Decorate instances with their schema reference and record count
                    JSONObject data = readData(ref);
                    info.setSchema(data.optString("schema", null));
                    JSONArray records = data.optJSONArray("records");
                    info.setRecordCount(records != null ? records.length() : 0);
                }
                result.add(info);
            }
            result.sort((a, b) -> a.getName().compareToIgnoreCase(b.getName()));
            return result;
        });
    }

    @Override
    public DatasetInfo getDataset(NodeRef nodeRef) {
        return getDataset(nodeRef, true);
    }

    @Override
    public DatasetInfo getDataset(NodeRef nodeRef, boolean includeContent) {
        return AuthenticationUtil.runAsSystem(() -> buildDatasetInfo(nodeRef, includeContent));
    }

    @Override
    public void deleteDataset(NodeRef nodeRef) {
        AuthenticationUtil.runAsSystem(() -> {
            nodeService.deleteNode(nodeRef);
            return null;
        });
    }

    // ===== versioning =====

    @Override
    public List<VersionInfo> getVersionHistory(NodeRef nodeRef) {
        return AuthenticationUtil.runAsSystem(() -> {
            VersionHistory history = versionService.getVersionHistory(nodeRef);
            if (history == null) return Collections.emptyList();

            List<VersionInfo> result = new ArrayList<>();
            for (Version v : history.getAllVersions()) {
                result.add(new VersionInfo(
                    v.getVersionLabel(),
                    v.getFrozenModifier(),
                    formatDate(v.getFrozenModifiedDate()),
                    v.getDescription()
                ));
            }
            return result;
        });
    }

    @Override
    public DatasetInfo getVersion(NodeRef nodeRef, String versionLabel) {
        return AuthenticationUtil.runAsSystem(() -> {
            VersionHistory history = versionService.getVersionHistory(nodeRef);
            if (history == null) return null;

            Version version = history.getVersion(versionLabel);
            if (version == null) return null;

            NodeRef frozenRef = version.getFrozenStateNodeRef();
            String content = "";
            ContentReader reader = contentService.getReader(frozenRef, ContentModel.PROP_CONTENT);
            if (reader != null && reader.exists()) {
                content = reader.getContentString();
            }

            String name = (String) nodeService.getProperty(nodeRef, ContentModel.PROP_NAME);
            String description = (String) nodeService.getProperty(nodeRef, ContentModel.PROP_DESCRIPTION);

            return new DatasetInfo(
                name,
                description,
                content,
                versionLabel,
                version.getFrozenModifier(),
                formatDate(version.getFrozenModifiedDate())
            );
        });
    }

    // ===== element CRUD (JSON Pointer) =====

    @Override
    public Object getElement(NodeRef nodeRef, String fieldPath) {
        return AuthenticationUtil.runAsSystem(() -> FieldPath.get(readData(nodeRef), fieldPath));
    }

    @Override
    public void setElement(NodeRef nodeRef, String fieldPath, Object value) {
        AuthenticationUtil.runAsSystem(() -> {
            JSONObject root = readData(nodeRef);
            FieldPath.set(root, fieldPath, value);
            writeData(nodeRef, root);
            return null;
        });
    }

    @Override
    public void appendElement(NodeRef nodeRef, String fieldPath, Object value) {
        AuthenticationUtil.runAsSystem(() -> {
            JSONObject root = readData(nodeRef);
            FieldPath.append(root, fieldPath, value);
            writeData(nodeRef, root);
            return null;
        });
    }

    @Override
    public void deleteElement(NodeRef nodeRef, String fieldPath) {
        AuthenticationUtil.runAsSystem(() -> {
            JSONObject root = readData(nodeRef);
            FieldPath.remove(root, fieldPath);
            writeData(nodeRef, root);
            return null;
        });
    }

    // ===== bootstrap =====

    @Override
    public void ensureDatasetsFolder() {
        AuthenticationUtil.runAsSystem(() -> {
            getOrCreateDatasetsFolder();
            return null;
        });
    }

    // ===== helpers =====

    // Dataset names are used as URL path segments, so a '/' would break addressing.
    private void validateName(String name) {
        if (name != null && name.contains("/")) {
            throw new IllegalArgumentException("Dataset name must not contain '/'");
        }
    }

    private JSONObject readData(NodeRef nodeRef) {
        ContentReader reader = contentService.getReader(nodeRef, ContentModel.PROP_CONTENT);
        String content = (reader != null && reader.exists()) ? reader.getContentString() : null;
        if (content == null || content.trim().isEmpty()) {
            content = "{}";
        }
        return new JSONObject(new JSONTokener(content));
    }

    private void writeData(NodeRef nodeRef, JSONObject root) {
        ContentWriter writer = contentService.getWriter(nodeRef, ContentModel.PROP_CONTENT, true);
        writer.setMimetype("application/json");
        writer.setEncoding("UTF-8");
        writer.putContent(root.toString(2));
    }

    @Override
    public NodeRef getDatasetNodeByName(String name) {
        return AuthenticationUtil.runAsSystem(() -> {
            NodeRef folder = getDatasetsFolder();
            if (folder == null || name == null) {
                return null;
            }
            return nodeService.getChildByName(folder, ContentModel.ASSOC_CONTAINS, name);
        });
    }

    // Read-only lookup of Data Dictionary > Datasets; returns null if it does not exist yet
    NodeRef getDatasetsFolder() {
        NodeRef rootRef = nodeService.getRootNode(StoreRef.STORE_REF_WORKSPACE_SPACESSTORE);
        NodeRef companyHome = findCompanyHome(rootRef);
        NodeRef dataDictionary = nodeService.getChildByName(companyHome, ContentModel.ASSOC_CONTAINS, "Data Dictionary");
        if (dataDictionary == null) {
            return null;
        }
        return nodeService.getChildByName(dataDictionary, ContentModel.ASSOC_CONTAINS, DssModel.DATASETS_FOLDER);
    }

    // Locates Data Dictionary > Datasets, creating the folder if absent (requires a read-write transaction)
    NodeRef getOrCreateDatasetsFolder() {
        NodeRef datasetsFolder = getDatasetsFolder();

        if (datasetsFolder == null) {
            NodeRef companyHome = findCompanyHome(nodeService.getRootNode(StoreRef.STORE_REF_WORKSPACE_SPACESSTORE));
            NodeRef dataDictionary = findChildByName(companyHome, "Data Dictionary");

            Map<QName, Serializable> props = new HashMap<>();
            props.put(ContentModel.PROP_NAME, DssModel.DATASETS_FOLDER);

            QName assocName = QName.createQName(
                NamespaceService.CONTENT_MODEL_1_0_URI,
                QName.createValidLocalName(DssModel.DATASETS_FOLDER)
            );
            ChildAssociationRef assoc = nodeService.createNode(
                dataDictionary,
                ContentModel.ASSOC_CONTAINS,
                assocName,
                ContentModel.TYPE_FOLDER,
                props
            );
            datasetsFolder = assoc.getChildRef();
        }

        return datasetsFolder;
    }

    private NodeRef findCompanyHome(NodeRef storeRoot) {
        // Company Home is a child of root via sys:children, not cm:contains
        List<ChildAssociationRef> rootChildren = nodeService.getChildAssocs(storeRoot);
        for (ChildAssociationRef assoc : rootChildren) {
            String name = (String) nodeService.getProperty(assoc.getChildRef(), ContentModel.PROP_NAME);
            if ("Company Home".equals(name)) {
                return assoc.getChildRef();
            }
        }
        throw new IllegalStateException("Cannot find Company Home under " + storeRoot);
    }

    private NodeRef findChildByName(NodeRef parent, String name) {
        NodeRef child = nodeService.getChildByName(parent, ContentModel.ASSOC_CONTAINS, name);
        if (child == null) {
            throw new IllegalStateException("Cannot find node: " + name + " under " + parent);
        }
        return child;
    }

    private DatasetInfo buildDatasetInfo(NodeRef nodeRef, boolean includeContent) {
        Map<QName, Serializable> props = nodeService.getProperties(nodeRef);
        String name = (String) props.get(ContentModel.PROP_NAME);
        String description = (String) props.get(ContentModel.PROP_DESCRIPTION);
        String modifier = (String) props.get(ContentModel.PROP_MODIFIER);
        Date modifiedDate = (Date) props.get(ContentModel.PROP_MODIFIED);
        String versionLabel = (String) props.get(ContentModel.PROP_VERSION_LABEL);

        String content = null;
        if (includeContent) {
            ContentReader reader = contentService.getReader(nodeRef, ContentModel.PROP_CONTENT);
            if (reader != null && reader.exists()) {
                content = reader.getContentString();
            }
        }

        return new DatasetInfo(
            name,
            description,
            content,
            versionLabel,
            modifier,
            formatDate(modifiedDate)
        );
    }

    private String formatDate(Date date) {
        if (date == null) return "";
        return new SimpleDateFormat(DATE_FORMAT).format(date);
    }
}
