# Alfresco Dataset Service 1.0.0

Initial release of the Alfresco Dataset Service, an Alfresco Content Services extension for
creating, editing, and managing **datasets** — flexible JSON documents stored as versioned
files in the repository — over a REST API and from a Share Admin Console page.

## Features

- **Flexible datasets** — each dataset is a user-defined JSON document (arbitrary fields and
  nested child nodes) stored as a `cm:content` file under `Data Dictionary > Datasets`, acting
  as a lightweight mock database store.
- **Whole-document CRUD** — create, list, get, replace, and delete datasets over REST.
- **Element CRUD** — read, set, append, and delete individual values inside a dataset addressed
  by JSON Pointer (RFC 6901), e.g. `/people/0/name` or `/people/-` to append.
- **Versioned** — every mutation creates a new version via Alfresco's `VersionService`, with
  full version history and restore.
- **Share admin console** — a JSON tree editor (add field / add child node / change type /
  delete) plus a raw-JSON edit mode and version history.
- **REST API** — repository web scripts under `/alfresco/s/alfresco/datasets` backing all
  operations.

## Compatibility

- Alfresco Content Services 25.1.0 (Community)
- Alfresco Share 25.1.0.56
- Java 17
- Built with Alfresco SDK 4.11.0

## Artifacts

- **`alfresco-dataset-service-platform-1.0.0.jar`** — repository tier;
  deploy to the ACS (`alfresco.war`) extension classpath.
- **`alfresco-dataset-service-share-1.0.0.jar`** — Share tier;
  deploy to the Alfresco Share (`share.war`) extension classpath.

## Installation

1. Copy `alfresco-dataset-service-platform-1.0.0.jar` into the ACS extension directory
   (e.g. `/usr/local/tomcat/webapps/alfresco/WEB-INF/lib` or the container's configured
   extension path) and restart the repository.
2. Copy `alfresco-dataset-service-share-1.0.0.jar` into the Share extension directory
   (e.g. `/usr/local/tomcat/webapps/share/WEB-INF/lib`) and restart Share.
3. Open the admin console:
   `http://<share-host>:<port>/share/page/console/admin-console/dataset-service`
   (the bundled Docker dev stack serves Share on port `8180`).

## License

Apache License 2.0.
