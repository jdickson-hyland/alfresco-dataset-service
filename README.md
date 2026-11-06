# Alfresco Dataset Service

An Alfresco Content Services extension for defining **dataset schemas** and managing the
**datasets** (records) that conform to them. Both are stored as versioned JSON files under
`Data Dictionary > Datasets` and are manageable over a REST API and from a Share admin console.
Built with Alfresco SDK 4.11.0 (AIO), targeting ACS 25.1.0 and Share 25.1.0.56.

## What it does

- Define a **schema** (the data model) — a JSON template of fields and types — stored as a
  versioned file named `<name>_schema.json`.
- Create **dataset instances** from a schema — records (key-value objects conforming to the
  schema), stored as `{ "schema": …, "records": [ … ] }` under a plain name.
- **Query** an instance's records over REST, optionally filtered by field value.
- Manage both from a Share **admin console** with **Schemas** and **Datasets** tabs: a JSON
  tree / raw editor for schemas, and a schema-driven **record form** for datasets.
- Fine-grained **element CRUD** (dot-notation field paths) plus full **version history / restore**
  on any document; every mutation creates a new version.
- Field/definition order is preserved on save and in query responses (JSON handled with Jackson).

## Data model

A document in the `Datasets` folder is one of two kinds, distinguished by its name:

- **Schema** — a JSON **object** template describing the fields/types. Named `<name>_schema.json`
  (the suffix is applied idempotently on save). Example `clients_schema.json`:

  ```json
  { "Forename": "", "Surname": "", "Id": 0, "Address": { "City": "" } }
  ```

- **Instance** — actual data conforming to a schema. Named plainly `<name>`; content references
  the schema and holds the records. Example `clients-eu`:

  ```json
  {
    "schema": "clients_schema.json",
    "records": [
      { "Forename": "Ada", "Surname": "Lovelace", "Id": 1, "Address": { "City": "Hull" } }
    ]
  }
  ```

Every file carries `cm:titled` (name/description), `cm:versionable`, and the `dss:dataset` marker
aspect (namespace `http://www.alfresco.org/model/datasetservice/1.0`, prefix `dss`). The
element API also addresses any value by a dot-notation field path, e.g. `records.0.Surname`,
`records.-` (append).

## REST API

Base: `/alfresco/s/alfresco/datasets` (admin authentication). Documents are addressed by **name**
(schemas by `<name>_schema.json`, instances by `<name>`); elements by a dot-notation **field** path.

| Method | Path | Purpose |
| ------ | ---- | ------- |
| GET    | `/datasets?type=schema\|instance` | List documents (filter by kind; default: all) |
| POST   | `/datasets` | Create a **schema** `{name, description?, data?}` → stored as `<name>_schema.json` |
| POST   | `/datasets` | Create an **instance** `{name, schema, records?, description?}` (body includes `schema`) |
| GET    | `/datasets/{name}` | Get one document incl. full JSON |
| PUT    | `/datasets/{name}` | Replace `{name?, description?, data?}` (rename; schemas keep the suffix) → new version |
| DELETE | `/datasets/{name}` | Delete |
| GET    | `/datasets/{name}/records` | **Query** an instance's records; `?field=value` (repeatable, AND) filters them |
| GET    | `/datasets/{name}/versions` · `/versions/{label}` | Version history / historical JSON |
| GET/PUT/POST/DELETE | `/datasets/{name}/data?field=<fieldPath>` | Element CRUD: read / set / append / remove a value → new version |

Example:

```bash
# 1) Create a schema (stored as clients_schema.json)
curl -u admin:admin -H 'Content-Type: application/json' \
  -d '{"name":"clients","data":{"Forename":"","Surname":"","Id":0,"Address":{"City":""}}}' \
  http://localhost:8080/alfresco/s/alfresco/datasets

# 2) Create a dataset instance from it
curl -u admin:admin -H 'Content-Type: application/json' \
  -d '{"name":"clients-eu","schema":"clients_schema.json","records":[
        {"Forename":"Ada","Surname":"Lovelace","Id":1,"Address":{"City":"Hull"}},
        {"Forename":"Grace","Surname":"Hopper","Id":2,"Address":{"City":"NYC"}}]}' \
  http://localhost:8080/alfresco/s/alfresco/datasets

# 3) Query its records, filtered by field
curl -u admin:admin \
  'http://localhost:8080/alfresco/s/alfresco/datasets/clients-eu/records?Surname=Hopper'
```

## Module layout

| Module | Purpose |
| ------ | ------- |
| `alfresco-dataset-service-platform` | Repository tier JAR (service, web scripts, content model) |
| `alfresco-dataset-service-share` | Share tier JAR (admin console page) |
| `alfresco-dataset-service-platform-docker` | ACS Docker image builder |
| `alfresco-dataset-service-share-docker` | Share Docker image builder |
| `alfresco-dataset-service-integration-tests` | Integration test module |

### Platform tier key files

```text
src/main/java/org/alfresco/datasetservice/
├── model/
│   ├── DssModel.java               QName constants (dss:dataset aspect, Datasets folder)
│   ├── DatasetInfo.java            API response POJO (+ schema / recordCount for instances)
│   └── VersionInfo.java            version history entry POJO
├── service/
│   ├── DatasetService(Impl).java   core-services wrapper; CRUD, versions, element ops,
│   │                               listSchemas()/listInstances() (schema vs instance by name suffix)
│   └── FieldPath.java              dot-notation get/set/append/remove on the JSON document
├── bootstrap/
│   └── DatasetServiceBootstrap.java  ensures Data Dictionary > Datasets exists
└── webscript/
    ├── AbstractDssWebScript.java   base: JSON I/O, dataset-name + field extraction, toSchemaName()
    ├── Datasets{List,Create}WebScript, Dataset{Get,Update,Delete}WebScript
    ├── DatasetRecordsGetWebScript  instance records query (field=value filters)
    ├── Dataset{Versions,VersionGet}WebScript
    └── DatasetElement{Get,Set,Add,Delete}WebScript
```

Create/update and the records query use **Jackson** to preserve JSON key order (`org.json`, used by
the element API, does not). Schemas are named `<name>_schema.json` via `toSchemaName()`; a create
body that includes a `schema` field is treated as an instance (plain name, `{schema, records}`).

The content model (`model/datasetServiceModel.xml`) is registered via `bootstrap-context.xml`;
all beans are wired in `context/datasetservice-context.xml` (web-script bean id convention:
`webscript.<descriptor-path-with-dots>.<method>`).

### Share tier key files

```text
src/main/resources/
├── alfresco/web-extension/share-config-dataset-service.xml    AdminConsole tool registration
└── alfresco/web-extension/site-webscripts/org/alfresco/datasetservice/
    ├── dataset-service.get.desc.xml
    ├── dataset-service.get.js       pre-loads the schema list server-side
    └── dataset-service.get.html.ftl admin UI + inline JS: Schemas tab (list, JSON tree/raw
                                     editor, versions) and Datasets tab (instance list,
                                     schema-driven record form, REST record filter)
```

## Prerequisites

- Docker and Docker Compose
- Maven 3.x and Java 17+

## Running

```bash
# Build and start the full stack (ACS, Share, Search Services, PostgreSQL, ActiveMQ)
./run.sh build_start

# Open the admin UI
open http://localhost:8180/share/page/console/admin-console/dataset-service

# Stop
./run.sh stop

# Stop and wipe all persistent data
./run.sh purge
```

`run.sh` defaults to a Dockerized Maven wrapper (`dmvn`); set `DOCKER_MVN=false` to use host `mvn`.

## Available run script commands

| Command | Description |
| ------- | ----------- |
| `build_start` | Build everything, recreate Docker images, start stack, tail logs |
| `start` | Start stack without rebuilding |
| `stop` | Stop all containers |
| `purge` | Stop and delete all Docker volumes (data is lost) |
| `tail` | Tail logs of all containers |
| `reload_share` | Rebuild and restart only the Share container |
| `reload_acs` | Rebuild and restart only the ACS container |
| `build_test` | Build, start, run integration tests, stop |
| `test` | Run integration tests against an already-running stack |

## Services and ports

| Service | Port |
| ------- | ---- |
| ACS (Alfresco Content Repository) | 8080 |
| Alfresco Share | 8180 |
| Alfresco Search Services (Solr) | 8983 |
| PostgreSQL | 5555 |
| ActiveMQ Web Console | 8161 |

## Notes

- Schema vs instance is distinguished purely by the `_schema.json` name suffix (no extra content
  model); schema-name lookups are case-insensitive (Alfresco `cm:name`).
- Whole-document and query paths preserve JSON field order (Jackson); the element API
  (`?field=…`, backed by `org.json`) does **not**, so element-level writes may reorder keys.
- All endpoints use the `AbstractWebScript` pattern (JSON written directly, no FreeMarker
  response template).
- Versioning uses Alfresco's built-in `VersionService`; `cm:versionable` is added before the
  first content write so version 1.0 always exists.
- All privileged operations (creating nodes in the Data Dictionary, reading/writing content)
  run via `AuthenticationUtil.runAsSystem()`.

## License

Apache License 2.0.
