---
layout: default
title: Dev hub integration: Keycloak
---

# Dev hub integration: Keycloak

* Make sure that Keycloak is set up as described in [Keycloak Installation Guide](https://maarten-vandeperre.github.io/developer-hub-documentation/keycloak/infra_setup_keycloak.html)
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
        metadataUrl: https://demo-keycloak-instance.apps.cluster-mq98c.mq98c.sandbox870.opentlc.com/realms/rhdh/.well-known/openid-configuration # ${AUTH_OIDC_METADATA_URL}
        clientId: rhdh-client # ${AUTH_OIDC_CLIENT_ID}
        clientSecret: 7iKyQUwyApIojzOlSj82vUWIhejv41E5 # ${AUTH_OIDC_CLIENT_SECRET}
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
* As a last step we need to make sure that the Keycloak users are synced with the Developer Hub's user catalog. In order to do so,
  we need to:
  * Enable the dynamic plugin for Keycloak by applying the following yaml to the dynamic plugins configuration (on anchor_01):
    ```yaml
    plugins:
      \- package: ./dynamic-plugins/dist/janus-idp-backstage-plugin-keycloak-backend-dynamic
        disabled: false
        pluginConfig: {}
    ```
  * Apply the following yaml to the Developer Hub config (on anchor_03):
    ```yaml
    catalog:
      providers:
        keycloakOrg:
          default:
            baseUrl: https://demo-keycloak-instance.apps.cluster-mq98c.mq98c.sandbox870.opentlc.com
            loginRealm: rhdh # ${KEYCLOAK_REALM} TODO enable via secret
            realm: rhdh # ${KEYCLOAK_REALM} TODO enable via secret
            clientId: rhdh-client # ${KEYCLOAK_CLIENTID} TODO enable via secret
            clientSecret: 7iKyQUwyApIojzOlSj82vUWIhejv41E5 # ${KEYCLOAK_CLIENTSECRET} TODO enable via secret
            # highlight-add-start
            schedule: # optional; same options as in TaskScheduleDefinition
              # supports cron, ISO duration, "human duration" as used in code
              frequency: { minutes: 1 }
              # supports ISO duration, "human duration" as used in code
              timeout: { minutes: 1 }
              initialDelay: { seconds: 15 }
              # highlight-add-end
    ```
* Now the login screen should be changed to:
  <img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/argo/images/login_screen_2.png">

_If you now create groups and users within Keycloak's rhdh realm, they will
become visible in Developer Hub: Catalog > Groups and Users._