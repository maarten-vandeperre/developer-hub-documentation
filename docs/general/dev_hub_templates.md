---
layout: default
title: Developer Hub Templates
---

# Developer Hub Templates

_For the remainder of this documentation pages, we will expect to start
from a clean state as described at the end of section [Configure Developer Hub](https://maarten-vandeperre.github.io/developer-hub-documentation/general/dev_hub_base_configuration.html). In order to not have
conflicts when skipping sections, I will highlight the places where the config needs to be added as follows:_    
     
     
_As an example: Adding this yaml_
```yaml
spec:
  presenter: maarten
``` 
_To this annotated template (on anchor_01)_
```yaml
config:
  metadata:
    name: demo-yaml
  <anchor_01>
```
_Would result in:_
```yaml
config:
  metadata:
    name: demo-yaml
  spec:
    presenter: maarten
```
_In case you get a second component to be added on anchor_01, let's say_
```yaml
spec:
  location: BeLux
```
_Then it would result in:_
```yaml
config:
  metadata:
    name: demo-yaml
  spec:
    presenter: maarten
    location: BeLux
```
_In case it would not be entirely clear, I will add the yaml definition which holds all the config
of all listed components beneath in the respectively yaml files (i.e., yaml file name will map on the name of the config map)._

**Templates to start from:**
* **Developer Hub (instance) Manifest:**  
  _Resulting file: [gitops/developer_hub/developer-hub-instance.yaml](https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/argo/gitops/developer_hub/31_developer-hub-instance.yaml)_
```yaml
apiVersion: rhdh.redhat.com/v1alpha1
kind: Backstage
metadata:
  name: developer-hub
  namespace: demo-project
spec:
  application:
    dynamicPluginsConfigMapName: dynamic-plugins-rhdh # added
    appConfig:
      mountPath: /opt/app-root/src
      configMaps: 
        - name: app-config-rhdh 
    extraFiles:
      mountPath: /opt/app-root/src
    extraEnvs:
      envs:
        # Disabling TLS verification
        - name: NODE_TLS_REJECT_UNAUTHORIZED
          value: '0'
      secrets: 
        - name: rhdh-secrets # added
    replicas: 1
    route:
      enabled: true
  database:
    enableLocalDb: true
```
* **Developer Hub Configuration**  
  _Resulting file: [gitops/developer_hub/app-config-rhdh.yaml](https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/argo/gitops/developer_hub/11_app-config-rhdh.yaml)_  
  **!! be aware**: project 'demo-project' is part of the url. Change it if you use another project
```yaml
kind: ConfigMap
apiVersion: v1
metadata:
  name: app-config-rhdh
  namespace: demo-project
data:
  app-config-rhdh.yaml: |
    <anchor_02>
    app:
      title: My Red Hat Developer Hub Instance
      baseUrl: https://backstage-developer-hub-demo-project.${basedomain}
    backend:
      auth:
        keys:
          - secret: ${BACKEND_SECRET}
      baseUrl: https://backstage-developer-hub-demo-project.${basedomain}
      cors:
        origin: https://backstage-developer-hub-demo-project.${basedomain}
    <anchor_03>
    <anchor_01>
```
* **Dynamic Plugin Configuration**  
  _Resulting file: [gitops/developer_hub/dynamic-plugins-rhdh.yaml](https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/argo/gitops/developer_hub/21_dynamic-plugins-rhdh.yaml)_
```yaml
kind: ConfigMap
apiVersion: v1
metadata:
  name: dynamic-plugins-rhdh
  namespace: demo-project
data:
  dynamic-plugins.yaml: |
    includes:
      - dynamic-plugins.default.yaml
    <anchor_01>
```