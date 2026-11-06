package org.alfresco.datasetservice.model;

import org.alfresco.service.namespace.QName;

public interface DssModel {

    String NAMESPACE = "http://www.alfresco.org/model/datasetservice/1.0";

    // Marker aspect applied to dataset files so they can be reliably identified.
    QName ASPECT_DATASET = QName.createQName(NAMESPACE, "dataset");

    // Data Dictionary folder that holds the dataset JSON files.
    String DATASETS_FOLDER = "Datasets";
}
