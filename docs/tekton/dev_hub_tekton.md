---
layout: default
title: Tekton Integration
---

# Tekton Integration

* Make sure that Tekton is set up as described in [Tekton Installation Guide](https://maarten-vandeperre.github.io/developer-hub-documentation/tekton/infra_setup_tekton.html)
    * Label: backstage.io/kubernetes-id: dev-hub-test-demo
* Now we are going to configure the Tekon integration
  within Developer Hub. In order to do so,
  we need to:
  * Enable the dynamic plugin for Tekton **(and Kubernetes!!)** by applying the following yaml to the dynamic plugins configuration (on anchor_01):
    ```yaml
      plugins:
        - package: ./dynamic-plugins/dist/janus-idp-backstage-plugin-tekton
          # documentation: https://docs.redhat.com/en/documentation/red_hat_plug-ins_for_backstage/1.0/html-single/tekton_plugin_for_backstage/index#setting-tekton-plugin
          disabled: false
        - package: ./dynamic-plugins/dist/backstage-plugin-kubernetes-backend-dynamic
          # documentation: https://backstage.io/docs/features/kubernetes/configuration/#config
          disabled: false
        - package: ./dynamic-plugins/dist/backstage-plugin-kubernetes
          disabled: false
    ```
  * Apply the following yaml to the Developer Hub config (on anchor_03):
    ```yaml
    catalog:
      providers:
        ocm:
          default:
            kubernetesPluginRef: local-cluster
            name: multiclusterhub
            owner: group:rhdh
            schedule:
              frequency:
                seconds: 10
              timeout:
                seconds: 60
    ```
  * Apply the following yaml to the Developer Hub config (on anchor_01):
    ```yaml
    kubernetes:
      clusterLocatorMethods:
        - clusters:
            - authProvider: serviceAccount
              name: local-cluster
              serviceAccountToken: ${RHDH_TEKTON_SERVICE_ACCOUNT_TOKEN}
              skipTLSVerify: true
              url: https://api.cluster-mq98c.mq98c.sandbox870.opentlc.com:6443
          type: config
      customResources:
        - apiVersion: v1beta1
          group: tekton.dev
          plural: pipelineruns
        - apiVersion: v1beta1
          group: tekton.dev
          plural: taskruns
        - apiVersion: v1
          group: route.openshift.io
          plural: routes
      serviceLocatorMethod:
        type: multiTenant
    ```
  * Now that the Tekton plugin is active, you'll need to link it to a component. throughout this example, we will use the component defined over here:
  [https://github.com/maarten-vandeperre/dev-hub-test-demo](https://github.com/maarten-vandeperre/dev-hub-test-demo), the
  [catalog-info.yaml](https://github.com/maarten-vandeperre/dev-hub-test-demo/blob/master/catalog-info.yaml)
  more in particular.
  In that catalog-info file, you will need to add the following annotations:
    * janus-idp.io/tekton: dev-hub-test-demo
      * janus-idp.io/tekton: the annotation name to activate the Tekton plugin for this component.
      * dev-hub-test-demo: the id defined in the tekton pipeline label (see above)

_If you now go to the CI tab on the component detail, you'll be able to see Tekton details:._

![Tekton](/assets/images/tekton/tekton_5.png)

**!!!Important**: when you get the error "Warning: There was a problem retrieving Kubernetes objects", it means that your service account token is expired.

![Tekton](/assets/images/tekton/tekton_4.png)

You can fix it by running the following commands:
* sh scripts/script_configure_tekton_integration.sh
* oc apply -f secrets/generated/secret_tekton.yaml
