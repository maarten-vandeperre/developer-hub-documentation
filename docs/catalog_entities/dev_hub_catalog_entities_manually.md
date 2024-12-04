---
layout: default
title: Add catalog entities manually
---

# Add catalog entities manually
In order to manually add catalog entities (i.e., not via integrations like the Keycloak binding), you will need to do two steps:
1. Define the catalog entities
2. Link them to the Developer Hub instance

## Define the catalog entities
Catalog entities definitions are defined [over here](https://backstage.io/docs/features/software-catalog/descriptor-format/). I have added an example implementation
for all of them, which you can find back in the folder [configurations/catalog-entities](https://github.com/maarten-vandeperre/developer-hub-documentation/tree/main/configurations/catalog-entities). If you want to link to them or import them,
you can refer to the GitHub URL: https://github.com/maarten-vandeperre/developer-hub-documentation/tree/main/configurations/catalog-entities.

The main file, which groups everything together is the all.yaml locations file. It will delegate to other locations files, for a specific catalog entity type
(e.g., domains-location.yaml, groups-and-users-location.yaml). Feel free to have a look at the definition files and to extend them
with your configuration(s). In case some modifications are not picked up, you can debug them as described in the [Debug Developer Hub Section](https://maarten-vandeperre.github.io/developer-hub-documentation/general/debug.html).

When imported successfully, you can find them back in the catalog menu within Developer Hub:

![Catalog Entities]({{site.url}}/assets/images/catalog_entities/catalog_entities_overview2.png)

The catalog graph as it is configured in my catalog-entities folder, results in the following catalog graph:

Without APIs for readability:

![Catalog Entities]({{site.url}}/assets/images/catalog_entities/catalog_graph_simple.png)

Without users for readability:

![Catalog Entities]({{site.url}}/assets/images/catalog_entities/catalog_graph_simple_2.png)

## Link the catalog entities to the Developer Hub instance.
In order to link the catalog entities (i.e., defined in previous section) to Developer Hub, you'll need to apply the
following yaml to the Developer Hub Config on anchor_02:
```yaml
catalog:
  processingInterval: { minutes: 1 }
  processing:
    cache:
      enabled: false
  lifecycles:
    - production
    - staging
  rules:
    - allow: [Location, Component, API, Resource, System, Domain, Group, User, Template]
  locations:
    - rules:
        - allow:
            - Group
            - User
            - Component
            - Location
            - System
            - Resource
            - Domain
            - API
            - Template
      target: https://github.com/maarten-vandeperre/developer-hub-documentation/blob/main/configurations/catalog-entities/all.yaml
      type: url
```

If you want to see it in a complete configuration file, feel free to have a look at [gitops/developer-hub/11_app-config-rhdh.yaml](https://github.com/maarten-vandeperre/developer-hub-documentation/tree/main/gitops/developer-hub/11_app-config-rhdh.yaml),
which contains all the integrations, described in this README file.

**!!! Have a close look to the API definitions:** I added both production and staging OpenAPI definitions, as in the real world,
API definitions can differ, depending on the given environment.