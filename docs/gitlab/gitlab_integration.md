---
layout: default
title: GitLab Integration
---

# GitLab Integration

The GitLab integration has a special entity provider for discovering catalog entities from GitLab. The entity provider
will crawl the GitLab instance and register entities matching the configured paths. This can be useful as an alternative
to static locations or manually adding things to the catalog.

More information about Dynamic Plugins [here](https://docs.redhat.com/en/documentation/red_hat_developer_hub/1.2/html-single/configuring_plugins_in_red_hat_developer_hub/index#rhdh-installing-dynamic-plugins).

To enable the GitLab integration and discovery capabilities a Personal Access Token (aka PAT) is required.

Create new Personal Access Token (aka PAT) in menu `Access Tokens` of the GitLab user profile:

- GitLab UI navigation: `Edit Profile` -> `Access Tokens` -> `Add new token`
- Name: `pat-gitlab-integration`
- Expiration date: Disabled it or just one in the future
- Set the scopes: `api`, `read_api`, `read_repository`, `write_repository`

Create a secret with the application id and secret created in GitLab:
Add the PAT to the previously created `gitlab-secrets` secret:

```yaml
kind: Secret
apiVersion: v1
metadata:
  name: gitlab-secrets
  namespace: rhdh-gitlab
stringData:
  GITLAB_TOKEN: REPLACE_WITH_YOUR_PAT
type: Opaque
```

Add the following to the `app-config-rhdh` ConfigMap:

```yaml
kind: ConfigMap
apiVersion: v1
metadata:
  name: app-config-rhdh
data:
  app-config-rhdh.yaml: |
    app:
      title: My Red Hat Developer Hub Instance
    integrations:
      gitlab:
        - host: gitlab.${basedomain}
          token: ${GITLAB_TOKEN}
          apiBaseUrl: https://gitlab.${basedomain}/api/v4
          baseUrl: https://gitlab.${basedomain}
```
