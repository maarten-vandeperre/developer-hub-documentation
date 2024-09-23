---
layout: default
title: Infra setup: Tekton
---

# Infra setup: Tekton
Tekton is a modern, cloud-native continuous integration and delivery (CI/CD) system designed to run on Kubernetes.
It provides a flexible framework for building, testing, and deploying applications through reusable, composable pipelines. 
Tekton uses Kubernetes-native resources, making it scalable, portable, and well-suited for cloud-based environments. 
Its pipeline-as-code approach allows developers to define workflows in YAML, which enhances flexibility and version control integration.

Running Tekton on OpenShift is advantageous because OpenShift’s Kubernetes foundation ensures seamless integration, 
leveraging Tekton's cloud-native architecture. OpenShift provides enhanced security, multi-tenancy, and developer tools, 
making it easier to manage and scale Tekton pipelines. Moreover, OpenShift’s ability to manage containerized workloads and its support for 
GitOps workflows make it an ideal platform for running Tekton in production environments.

In this section we will install Tekton on OpenShift.

## Installation
In order to install and configure Tekton on OpenShift you will need to execute the following steps, as you can find back in the default
[script_init_cluster.sh](https://github.com/maarten-vandeperre/developer-hub-documentation/blob/main/script_init_cluster.sh) script:
* Create persistent volumes:
  * oc apply -f gitops/tekton/tekton-persistence-volume-claim-app-source.yaml
  * oc apply -f gitops/tekton/tekton-persistence-volume-claim-gradle-cache.yaml
* Install the operator:
  * oc apply -f gitops/tekton/tekton-operator.yaml
* Configure the service account for tekton
  * oc apply -f gitops/tekton/tekton-service-account.yaml
  * sh scripts/script_configure_tekton_integration.sh
* Create the pipeline
  * oc apply -f gitops/tekton/tekton-pipeline-simple-hello-world.yaml
* Create a pipeline run (!! when you want to run it a second time, you'll need to change the suffix on the name field)
  * oc apply -f gitops/tekton/tekton-pipeline-run-simple-hello-world.yaml
  
You then should be able to see the pipeline and pipeline run in OpenShift:
<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/argo/images/tekton_1.png" class="large">    

<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/argo/images/tekton_2.png" class="large">  
