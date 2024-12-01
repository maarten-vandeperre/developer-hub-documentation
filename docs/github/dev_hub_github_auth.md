---
layout: default
title: GitHub Auth
---

# GitHub Auth

* Make sure that GitHub is set up as described in [GitHub Token Configuration Guide](https://maarten-vandeperre.github.io/developer-hub-documentation/github/token_configurations.html)
    * Get the client id of the application
    * Get the client secret of the application
      * Now we are going to configure GitHub to allow authentication
        within Developer Hub. Apply the following yaml definition to the Developer Hub Config on anchor_01:
        ```yaml
        auth:
          environment: default
          session:
            secret: ${BACKEND_SECRET}
          providers:
            github:
              default:
                clientId: ${RHDH_GITHUB_INTEGRATION_APP_CLIENT_ID}
                clientSecret: ${RHDH_GITHUB_INTEGRATION_APP_CLIENT_SECRET}
        ```
* By applying above config, you enable a new authentication provider to be used. By adding this info, the provider is not yet in use.
  In order to start using this GitHub provider, we have to apply the following yaml to the Developer Hub Config on anchor_02.
```yaml
signInPage: github
```
* As a last step we need to make sure that the GitHub users are synced with the Developer Hub's user catalog. In order to do so,
  we need to:
  * Enable the dynamic plugin for GitHub by applying the following yaml to the dynamic plugins configuration (on anchor_01):
    ```yaml
      plugins:
        - package: ./dynamic-plugins/dist/backstage-plugin-catalog-backend-module-github-dynamic
          # documentation: https://backstage.io/docs/integrations/github/discovery/
          disabled: false
    ```
  * Apply the following yaml to the Developer Hub config (on anchor_03):
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
  * Add a GitHub integration configuration by applying the following yaml to the Developer Hub Config on anchor_02:
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
* Now the login screen should be changed to:

  ![GtiHub](/assets/images/github/login_screen_3.png)