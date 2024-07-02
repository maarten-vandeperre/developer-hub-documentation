# Developer Hub Documentation

**_All actions will be executed within the 'demo-project' namespace on OpenShift, unless otherwise specified.
Next to that, be aware that the root domain will be different for you, and it will be the root domain of your
OpenShift cluster._**

## Install required tooling
This section will list tooling required to be set up if you would like to go through the entire demo.
Optional tools/components will be annotated with '*', meaning that, if you don't want to include them 
within your Developer Hub instance, you don't have to configure or install them.

Tools:
* **Keycloak**:  
Will be used for authentication (i.e., logging in) into Developer Hub.  
[Keycloak Installation Guide](README-InstallKeycloak.md)

## Install Red Hat Developer Hub
### Install Red Hat Developer Hub via operator
* Install the operator on OpenShift in the operator recommended namespace.
* Apply the following yaml:
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
    extraFiles:
      mountPath: /opt/app-root/src
    replicas: 1
    route:
      enabled: true
  database:
    enableLocalDb: true
```
* Wait for status to become "Deployed"
* Get the route to Developer Hub:
```shell
oc get route $(oc get routes -n demo-project -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}' | grep developer-hub) \
  -n demo-project \
  -o template --template='{{.spec.host}}'\ 
  ; echo
```
* _In our case: backstage-developer-hub-demo-project.apps.cluster-b97l9.dynamic.redhatworkshops.io_

### Install Red Hat Developer Hub via Helm chart
[Helm chart install guide](https://developers.redhat.com/learning/learn:openshift:install-and-configure-red-hat-developer-hub-and-explore-templating-basics/resource/resources:install-red-hat-developer-hub-developer-sandbox-red-hat-openshift)

## Configure Developer Hub

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
* Set the base domain variable.  
  **_!!! Be careful, the base domain will be different in your setup._**
```shell
basedomain=apps.cluster-b97l9.dynamic.redhatworkshops.io
```
* Patch the secret to add the base domain (i.e., to avoid CORS issues).  
```shell
oc patch secret rhdh-secrets -n demo-project -p '{"stringData":{"basedomain":"'"${basedomain}"'"}}'
```
* Configuration of Developer Hub is stored in a config map. This is what we are going to create via applying the following yaml:  
  **!! be aware**: project 'demo-project' is part of the url. Change it if you use another project
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
* Go to Developer Hub: _(in our case)_ backstage-developer-hub-demo-project.apps.cluster-b97l9.dynamic.redhatworkshops.io
* You should now be able to see the following screen:
  ![](images/login_screen_1.png "")
* Last thing to configure now is the enablement of the dynamic plugins. These dynamic plugins will allow you to add functionality 
to Developer Hub without having to change the (React) source code (as it is done in the upstream Backstage project). For this we will
need to add an extra config map (i.e., dynamic plugin configuration) and link this configuration in the Developer Hub (instance) manifest.
  * Create the dynamic plugin configuration by applying the following yaml:
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
#    plugins: leave this one out for now as it will give errors on startup (not needed at the moment anyway as we don't have plugins yet).
```
  * Link the configuration to the Developer Hub (instance) manifest by applying the following yaml:
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

## Developer Hub Configurations

**_For the remainder (i.e. section [Developer Hub Configurations](#developer-hub-configurations)), we will expect to start
from a clean state as described at the end of section [Configure Developer Hub](#configure-developer-hub). In order to not have
conflicts when skipping sections, I will highlight the places where the config needs to be added as follows:_**  
_Adding this yaml_
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
_Resulting file: [resulting_manifests/developer-hub-instance.yaml](resulting_manifests/developer-hub-instance.yaml)_
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
_Resulting file: [resulting_manifests/app-config-rhdh.yaml](resulting_manifests/app-config-rhdh.yaml)_  
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
    <anchor_01>
```
* **Dynamic Plugin Configuration**  
_Resulting file: [resulting_manifests/dynamic-plugins-rhdh.yaml](resulting_manifests/dynamic-plugins-rhdh.yaml)_
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

### Enable authentication via Keycloak
* Make sure that Keycloak is set up as described in [Keycloak Installation Guide](README-InstallKeycloak.md)
  * Get the base url
  * Realm: rhdh
  * ClientId: rhdh-client
  * ClientSecret: view/copy it from keycloak
* Now we are going to configure OpenID (Keycloak for us) to allow OpenID-based authentication 
within Developer Hub. Apply the following yaml definition to the Developer Hub Config on anchor_01:
```yaml
auth:
  environment: development
  session:
    secret: ${BACKEND_SECRET}
  providers:
    oidc:
      development:
#        metadataUrl: <keycloak_base_url>/realms/rhdh/.well-known/openid-configuration # ${AUTH_OIDC_METADATA_URL}
        metadataUrl: https://demo-keycloak-instance.apps.cluster-b97l9.dynamic.redhatworkshops.io/realms/rhdh/.well-known/openid-configuration # ${AUTH_OIDC_METADATA_URL}
        clientId: rhdh-client # ${AUTH_OIDC_CLIENT_ID}
        clientSecret: MiF4P4tDFl3oWrisy7VdUOqngoNlv71D # ${AUTH_OIDC_CLIENT_SECRET}
        prompt: auto # ${AUTH_OIDC_PROMPT} # recommended to use auto
        ## uncomment for additional configuration options
        # callbackUrl: ${AUTH_OIDC_CALLBACK_URL}
        # tokenEndpointAuthMethod: ${AUTH_OIDC_TOKEN_ENDPOINT_METHOD}
        # tokenSignedResponseAlg: ${AUTH_OIDC_SIGNED_RESPONSE_ALG}
        # scope: ${AUTH_OIDC_SCOPE}
        ## Auth provider will try each resolver until it succeeds. Uncomment the resolvers you want to use to override the default resolver: `emailLocalPartMatchingUserEntityName`
        signIn:
          resolvers:
            - resolver: preferredUsernameMatchingUserEntityName
        #    - resolver: emailMatchingUserEntityProfileEmail
        #    - resolver: emailLocalPartMatchingUserEntityName
```
* By applying above config, you enable a new authentication provider to be used. By adding this info, the provider is not yet in use. 
In order to start using this oidc (i.e. OpenId Connect) provider, we have to apply the following yaml to the Developer Hub Config on anchor_02.
```yaml
signInPage: oidc  
```
* Now the login screen should be changed to:
  ![](images/login_screen_2.png "")
