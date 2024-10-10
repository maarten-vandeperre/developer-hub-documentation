---
layout: default
title: Developer Hub Documentation
---

# Developer Hub Documentation

Welcome on this Developer Hub documentation (showcase) page, of which you can find [the source 
code over here.](https://github.com/maarten-vandeperre/developer-hub-documentation)
This document should provide all necassary information required to get Developer Hub 
and quite some integrations up and running in no-time.  

Main layout of this repository:
* **Configurations folder:** Containing metadata in scope of Developer Hub integrations or required OpenShift deployments.
* **GitOps folder:** Containing all yaml definitions required to install the underlying components (e.g., 3scale, Keycloak, ArgoCD, ...) on OpenShift. 
If you want to install such a component, the [default installation script](https://github.com/maarten-vandeperre/developer-hub-documentation/blob/main/script_init_cluster.sh) 
and this folder will be a good starting point.
* **Scripts folder:** Containing all helper scripts to manipulate/help configuring underlying technologies and secrets.
* **Docs folder:** The GitHub pages source folder.


**_All actions will be executed within the 'demo-project' namespace on OpenShift, unless otherwise specified.
Next to that, be aware that the root domain will be different for you, and it will be the root domain of your
OpenShift cluster._**


## Automated Install

If you would like to have an OpenShift cluster with all integrations configured automatically for you, you can use the 'script_init_cluster.sh' script.

### Steps:
1. Ensure you have a running OpenShift cluster without a project named 'demo-project'.
2. Copy and execute the 'oc login' command.
3. Fork [this GitHub repository](https://github.com/maarten-vandeperre/dev-hub-test-demo) to your repository list or create a new repository and copy the catalog-info.yaml file over.
4. Execute the 'script_init_cluster.sh'.

Next to that, there is the 'scripts/script_prepare_repository.sh', which will configure all URLs to be pointing to your OpenShift environment 
(after oc login was executed).
