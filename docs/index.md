---
layout: default
title: Developer Hub Documentation
---

# Developer Hub Documentation

Welcome on this Developer Hub documentation (showcase) page.
This document should provide al necassary information required to get Developer Hub 
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
