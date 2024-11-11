---
layout: default
title: 3scale Integration
---

# 3scale integration

* Make sure that 3scale is set up as described in [3scale Installation Guide](https://maarten-vandeperre.github.io/developer-hub-documentation/3scale/infra_setup_3scale.html)
  * Get admin organization of the tenant you want to connect: https://demo-organization-maarten-admin.apps.cluster-mq98c.mq98c.sandbox870.opentlc.com
  * Username: admin
  * Password: averysecurepassword
  * Token: oc get secret tenant-secret -n demo-project -o template --template='{{.data.token}}' | base64 -d ; echo
* Now we are going to configure the 3scale integration
  within Developer Hub. In order to do so,
  we need to:
  * Enable the dynamic plugin for 3scale by applying the following yaml to the dynamic plugins configuration (on anchor_01):
    ```yaml
      plugins:
        - package: ./dynamic-plugins/dist/janus-idp-backstage-plugin-3scale-backend-dynamic
          disabled: false
          pluginConfig: {}
    ```
  * Apply the following yaml to the Developer Hub config (on anchor_03):
    ```yaml
    catalog:
      providers:
        threeScaleApiEntity:
          default:
            baseUrl: https://demo-organization-maarten-admin.apps.cluster-mq98c.mq98c.sandbox870.opentlc.com
            accessToken: ${RHDH_3SCALE_RHDH_CLIENT_SECRET}
            schedule: # optional; same options as in TaskScheduleDefinition
              # supports cron, ISO duration, "human duration" as used in code
              frequency: { minutes: 1 }
              # supports ISO duration, "human duration" as used in code
              timeout: { minutes: 3 }
    ```

_If you now wait for the 3scale provider to import the APIs, you should be able to see it pop up in the API section:._
<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/api-list-with-3scale-api.png" class="large">