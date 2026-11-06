package org.alfresco.datasetservice.bootstrap;

import org.alfresco.datasetservice.service.DatasetService;
import org.alfresco.repo.module.AbstractModuleComponent;
import org.alfresco.repo.security.authentication.AuthenticationUtil;

public class DatasetServiceBootstrap extends AbstractModuleComponent {

    private DatasetService datasetService;

    public void setDatasetService(DatasetService datasetService) {
        this.datasetService = datasetService;
    }

    @Override
    protected void executeInternal() {
        AuthenticationUtil.runAsSystem(() -> {
            datasetService.ensureDatasetsFolder();
            return null;
        });
    }
}
