---
layout: default
title: GitLab Auth
---

# GitLab Auth

>
> Red Hat Developer Hub 1.3 only supports Microsoft Azure, GitHub and Keycloak as authentication providers;
> more info [here](https://access.redhat.com/solutions/7081356).
> There is an ongoing [epic](https://issues.redhat.com/browse/RHIDP-3991) to cover it in following releases.
> This configuration should work to authenticate users by GitLab, as Backstage provides.
>

Enabling GitLab authentication requires to create a GitLab application.
This process is described [here](https://backstage.io/docs/auth/gitlab/provider), however, keep in mind to
execute the actions in your GitLab instance:

- GitLab UI navigation: Edit `Profile` -> `Applications` -> `Add new application`
- Name: `rhdh-gitlab-integration` (as example)
- Redirect URI: `https://{RHDH_FQDN}/api/auth/gitlab/handler/frame` where `RHDH_FQDN` represents the full qualified url to Red Hat Developer Hub.
- Set the correct permissions: `api`, `read_user`, `read_repository`, `write_repository`, `openid`, `profile`, `email`

**NOTE**: You can get the full qualified url to Red Hat Developer Hub with following command, using the name of your
Red Hat Developer Hub instance name (`RHDH_CR_NAME`):

`echo https://$(oc get route backstage-{RHDH_CR_NAME} -o jsonpath='{.spec.host}')`

Create a secret with the application id and secret created in GitLab:

```yaml
kind: Secret
apiVersion: v1
metadata:
  name: gitlab-secrets
  namespace: rhdh-gitlab
stringData:
  AUTH_GITLAB_CLIENT_ID: REPLACE_WITH_YOUR_GITLAB_CLIENT_ID
  AUTH_GITLAB_CLIENT_SECRET: REPLACE_WITH_YOUR_GITLAB_CLIENT_SECRET
type: Opaque
```

**NOTE**: If you want to create this secret in the OpenShift Web Console, you need to base64-decode the `AUTH_GITLAB_CLIENT_ID`" and `AUTH_GITLAB_CLIENT_SECRET` values.

Next, add the new secret to the backstage manifest:

```yaml
spec:
  application:
    # other configuration
    extraEnvs:
      secrets:
        - name: gitlab-secrets
```

Update the configuration of Red Hat Developer Hub to define the GitLab authentication provider:

```yaml
  auth:
    signInPage: gitlab
    auth:
      environment: production
      providers:
        gitlab:
          production:
            clientId: ${AUTH_GITLAB_CLIENT_ID}
            clientSecret: ${AUTH_GITLAB_CLIENT_SECRET}
```

Notice that we set the `signInPage` to `gitlab`, the default is `github`.

> **_NOTE:_** To disable guest login set the `environment` to `production`!

Verify that you can login with GitLab.
