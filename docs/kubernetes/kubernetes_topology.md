---
layout: default
title: Dev hub integration: Kubernetes Topology
---

# Dev hub integration: Kubernetes Topology

* No prior configuration is required, just make sure that you have at least one deployment running with a "backstage.io/kubernetes-id: dev-hub-test-demo" label.
  (E.g., [gitops/microservices-gitops/simple-hello-world-gitops/simple-hello-world-deployment.yaml](https://github.com/maarten-vandeperre/developer-hub-documentation/tree/main/gitops/microservices-gitops/simple-hello-world-gitops/simple-hello-world-deployment.yaml)).
* Now we are going to configure the Kubernetes topology integration
  within Developer Hub. In order to do so,
  we need to:
  * Enable the dynamic plugin for Kubernetes by applying the following yaml to the dynamic plugins configuration (on anchor_01):
    ```yaml
      plugins:
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
      serviceLocatorMethod:
        type: multiTenant
    ```
  * Now that the Kubernetes plugin is active, you'll need to link it to a component. throughout this example, we will use the component defined over here:
  [https://github.com/maarten-vandeperre/dev-hub-test-demo](https://github.com/maarten-vandeperre/dev-hub-test-demo), the 
  [catalog-info.yaml](https://github.com/maarten-vandeperre/dev-hub-test-demo/blob/master/catalog-info.yaml)
  more in particular.
  In that catalog-info file, you will need to add the following annotations:
    * backstage.io/kubernetes-namespace: demo-project
      * backstage.io/kubernetes-namespace: the annotation name to activate the Kubernetes topology plugin for this component.
      * demo-project: the namespace in OpenShift to monitor.
    * backstage.io/kubernetes-id: dev-hub-test-demo
      * backstage.io/kubernetes-id: the annotation name to activate the Kubernetes topology plugin for this component.
      * dev-hub-test-demo: the id defined in the deployment label (see above)

_If you now go to the Topology tab on the component detail, you'll be able to see Kubernetes details:._
<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/topology_1.png" class="large">  


**!!!Important**: when you get the error "Warning: There was a problem retrieving Kubernetes objects", it means that your service account token is expired.
<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/tekton_4.png" class="large">  
You can fix it by running the following commands (i.e., same as to fix tekton):
* sh scripts/script_configure_tekton_integration.sh 
* oc apply -f secrets/generated/secret_tekton.yaml
