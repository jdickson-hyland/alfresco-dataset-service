package org.alfresco.datasetservice.service;

import org.alfresco.datasetservice.model.DatasetInfo;
import org.alfresco.datasetservice.model.VersionInfo;
import org.alfresco.service.cmr.repository.NodeRef;

import java.util.List;

/**
 * Manages datasets: flexible JSON documents stored as versioned files in
 * Data Dictionary &gt; Datasets. Supports whole-document CRUD plus fine-grained
 * element CRUD addressed by JSON Pointer, treating each file as a mock database.
 */
public interface DatasetService {

    // ----- whole-document CRUD -----

    NodeRef createDataset(String name, String description, String jsonContent);

    NodeRef updateDataset(NodeRef nodeRef, String name, String description, String jsonContent);

    List<DatasetInfo> listDatasets();

    /** Lists schema documents only (names ending in {@code _schema.json}). */
    List<DatasetInfo> listSchemas();

    /** Lists dataset instances only (everything that is not a schema); infos carry schema + recordCount. */
    List<DatasetInfo> listInstances();

    /** Resolves a dataset by its name within the Datasets folder; null if not found. */
    NodeRef getDatasetNodeByName(String name);

    DatasetInfo getDataset(NodeRef nodeRef);

    DatasetInfo getDataset(NodeRef nodeRef, boolean includeContent);

    void deleteDataset(NodeRef nodeRef);

    // ----- versioning -----

    List<VersionInfo> getVersionHistory(NodeRef nodeRef);

    DatasetInfo getVersion(NodeRef nodeRef, String versionLabel);

    // ----- element CRUD (JSON Pointer addressed) -----

    /** Returns the JSON value at the dot-notation field path (empty = whole document). */
    Object getElement(NodeRef nodeRef, String fieldPath);

    /** Sets/replaces the value at the field path, creating intermediate objects as needed. */
    void setElement(NodeRef nodeRef, String fieldPath, Object value);

    /** Appends a value to the array located at the field path. */
    void appendElement(NodeRef nodeRef, String fieldPath, Object value);

    /** Removes the member located at the field path. */
    void deleteElement(NodeRef nodeRef, String fieldPath);

    // ----- bootstrap -----

    void ensureDatasetsFolder();
}
