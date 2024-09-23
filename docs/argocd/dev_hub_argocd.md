---
layout: default
title: Dev hub integration: ArgoCD
---

# Dev hub integration: ArgoCD

* Make sure that ArgoCD is set up as described in [ArgoCD Installation Guide](https://maarten-vandeperre.github.io/developer-hub-documentation/argocd/infra_setup_argocd.html)
    * Label: rht-gitops.com/demo-project: simple-hello-world-service-a
* Now we are going to configure the ArgoCD integration
  within Developer Hub. In order to do so,
  we need to:
  * Enable the dynamic plugin for ArgoCD by applying the following yaml to the dynamic plugins configuration (on anchor_01):
    ```yaml
      plugins:
        - package: ./dynamic-plugins/dist/roadiehq-backstage-plugin-argo-cd-backend-dynamic
          # documentation: https://docs.redhat.com/en/documentation/red_hat_developer_hub/0.1/html/argocd_plugin_for_backstage/argocd-plugin-for-backstage#installation
          # documentation: https://docs.redhat.com/en/documentation/red_hat_developer_hub/1.2/html/configuring_plugins_in_red_hat_developer_hub/rhdh-installing-dynamic-plugins#enabling-argo-cd-plugin
          disabled: false
        - package: ./dynamic-plugins/dist/janus-idp-backstage-plugin-argocd
          disabled: false
        - package: ./dynamic-plugins/dist/roadiehq-scaffolder-backend-argocd-dynamic
          disabled: false
    ```
  * Apply the following yaml to the Developer Hub config (on anchor_01):
    ```yaml
    argocd:
      appLocatorMethods:
        - type: 'config'
          instances:
            - name: argoInstance1
              url: https://argocd-instance-server-demo-project.apps.cluster-mq98c.mq98c.sandbox870.opentlc.com
              username: admin 
              password: ${RHDH_ARGOCD_ADMIN_PWD}
    ```
  * Now that the ArgoCD plugin is active, you'll need to link it to a component. throughout this example, we will use the component defined over here:
  [https://github.com/maarten-vandeperre/dev-hub-test-demo](https://github.com/maarten-vandeperre/dev-hub-test-demo), the 
  [catalog-info.yaml](https://github.com/maarten-vandeperre/dev-hub-test-demo/blob/master/catalog-info.yaml)
  more in particular.
  In that catalog-info file, you will need to add the following annotations:
    * argocd/app-selector: rht-gitops.com/demo-project=simple-hello-world-service-a
      * argocd/app-selector: the annotation name to activate the ArgoCD plugin for this component.
      * rht-gitops.com/demo-project=simple-hello-world-service-a: the label defined in the ArgoCD application definition (see above)
    * argocd/instance-name: argoInstance1
      * argocd/instance-name: the annotation name to activate the ArgoCD plugin for this component.
      * argoInstance1: name of the ArgoCD instance, as defined in the app config.

_If you now go to the CD tab on the component detail, you'll be able to see ArgoCD details:._
<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/argo/images/argocd_4.png" class="large">  


**!!! Important:** If you get an TLS error, check if your ArgoCD instance if using selfsigned certificates. If it does, make sure you disable certificate
checkin in the backstage instance definition (i.e., avoid this in production!).
```yaml
    extraEnvs:
      envs:
        # Disabling TLS verification
        - name: NODE_TLS_REJECT_UNAUTHORIZED
          value: '0'
```
<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/argo/images/argocd-internal-server-error-2.png" class="large">  
