---
layout: default
title: Enable and add software templates
---

# Enable and add software templates

In order to enable software templates (for GitHub), the only first thing you'll need to do, is configuring a GitHub application that has the permission to
create Git repositories (see [How to configure GitHub applications](https://maarten-vandeperre.github.io/developer-hub-documentation/github/token_configurations.html)).

In order to enable component scanning from GitHub to Developer Hub (i.e., catalog entity type Component),
you'll need to execute the following steps:
1. Enable the Catalog Backend Module GitHub plugin by applying the following yaml to the dynamic plugins configuration (on anchor_01):
    ```yaml
    - package: ./dynamic-plugins/dist/backstage-plugin-catalog-backend-module-github-dynamic
      # documentation: https://backstage.io/docs/integrations/github/discovery/
      disabled: false
      pluginConfig: {}
    ```
2. Add a provider, which scans your GitHub repositories every x time and creates or updates
   Component definitions in Developer Hub by applying the following yaml to the Developer Hub Config on anchor_02:
    ```yaml
    catalog:
      providers:
        github:
          # the provider ID can be any camelCase string
          providerId:
            organization: 'maarten-vandeperre' # string
            catalogPath: '/catalog-info.yaml' # string
            filters:
              branch: 'master' # string
              repository: '.*' # Regex
            schedule: # optional; same options as in TaskScheduleDefinition
              # supports cron, ISO duration, "human duration" as used in code
              frequency: { minutes: 1 }
              # supports ISO duration, "human duration" as used in code
              timeout: { minutes: 1 }
              initialDelay: { seconds: 15 }
    ```

   Most important configurations:
    * catalogPath: the catalog entity Component type definition, which describes the given component.
    * filters > branch: branch to look at.
    * repository: I will scan all my repositories, so I add a regular expression, covering everything.

   If you want to see it in a complete configuration file, feel free to have a look at [gitops/developer-hub/11_app-config-rhdh.yaml](https://github.com/maarten-vandeperre/developer-hub-documentation/tree/argo/gitops/developer-hub/11_app-config-rhdh.yaml),
   which contains all the integrations, described in this README file.
3. Add a GitHub integration configuration by applying the following yaml to the Developer Hub Config on anchor_02:
    ```yaml
    integrations:
      github:
        - host: github.com
          token: ${RHDH_GITHUB_INTEGRATION_PERSONAL_ACCESS_TOKEN}
          apps:
            - appId: ${RHDH_GITHUB_INTEGRATION_APP_ID}
              clientId: ${RHDH_GITHUB_INTEGRATION_APP_CLIENT_ID}
              clientSecret: ${RHDH_GITHUB_INTEGRATION_APP_CLIENT_SECRET}
              webhookUrl: none
              webhookSecret: none
              privateKey: ${RHDH_GITHUB_INTEGRATION_APP_PRIVATE_KEY}
    ```
   _Note: The token is optional, but if you don't configure it, you'll run rather fast against GitHub API rate limits. So I would advise to have
   some kind of system user account in place to link to the catalog scanning configuration._

   If you want to see it in a complete configuration file, feel free to have a look at [gitops/developer-hub/11_app-config-rhdh.yaml](https://github.com/maarten-vandeperre/developer-hub-documentation/tree/argo/gitops/developer-hub/11_app-config-rhdh.yaml),
   which contains all the integrations, described in this README file.
4. Now you should be able to see the repositories in your GitHub account that have a
   Component definition (i.e., catalog-info.yaml file) in their root. If for some reason it is not
   popping up, try as well the console log for debugging ends or [check the database](https://maarten-vandeperre.github.io/developer-hub-documentation/general/debug.html).