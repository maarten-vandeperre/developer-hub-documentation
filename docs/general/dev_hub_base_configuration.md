---
layout: default
title: Developer Hub Base Configuration
---

# Developer Hub Base Configuration

When Developer Hub is installed via the operator there are some mandatory settings that need to be set:

* Create a backend secret (this is a mandatory secret), by applying the following yaml:

```yaml
kind: Secret
apiVersion: v1
metadata:
  name: rhdh-secrets
  namespace: demo-project
stringData:
  BACKEND_SECRET: averysecretpassword
type: Opaque
```

* set the base domain variable to enable proper navigation and CORs settings. This command will get it your current OpenShift cluster:

```shell
export basedomain=$(oc get ingresscontroller -n openshift-ingress-operator default -o jsonpath='{.status.domain}')
```

* Patch the secret to add the base domain (i.e., to avoid CORS issues):

```shell
oc patch secret rhdh-secrets -n demo-project -p '{"stringData":{"basedomain":"'"${basedomain}"'"}}'
```

* A good practice is using a ConfigMap including an application file to customize the instance. This is what
we are going to create via applying the following yaml:

  **!! BE AWARE**: Project 'demo-project' is part of the url. Change it if you use another project.

```yaml
kind: ConfigMap
apiVersion: v1
metadata:
  name: app-config-rhdh
  namespace: demo-project
data:
  app-config-rhdh.yaml: |
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
```

* Now we just have to change the manifest (i.e., instance description), in which we add a reference to the secrets file and the configuration, by applying the following yaml:

  _The yaml is already a modified version of the one mentioned above_

```yaml
apiVersion: rhdh.redhat.com/v1alpha1
kind: Backstage
metadata:
  name: developer-hub
  namespace: demo-project
spec:
  application:
    appConfig:
      mountPath: /opt/app-root/src
      configMaps: # added
        - name: app-config-rhdh # added
    extraFiles:
      mountPath: /opt/app-root/src
    extraEnvs:
      envs:
        # Disabling TLS verification
        - name: NODE_TLS_REJECT_UNAUTHORIZED
          value: '0'
      secrets: # added
        - name: rhdh-secrets # added
    replicas: 1
    route:
      enabled: true
  database:
    enableLocalDb: true
```

* Navigate to Developer Hub, you should now be able to see the following screen:

  <img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/login_screen_1.png" class="large">

* Last thing to configure now is the enablement of the dynamic plugins. These dynamic plugins will allow
you to add functionality to Developer Hub without having to change the (React) source code (as it is done
in the upstream Backstage project). For this we will need to add an extra ConfigMap (i.e., dynamic plugin
configuration) and link this configuration in the Developer Hub (instance) manifest.
Create the dynamic plugin configuration by applying the following yaml:

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
      # plugins: leave this one out for now as it will give errors on startup (not needed at the moment anyway as we don't have plugins yet).
```

Link the configuration to the Developer Hub (instance) manifest by applying the following yaml:

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

This will be the base manifest configuration for the Developer Hub instance for many of the other chapters
of this site.
