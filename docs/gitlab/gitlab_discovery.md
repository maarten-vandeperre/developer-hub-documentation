---
layout: default
title: Enable GitLab discovery
---

# GitLab Discovery

Once we have integrated GitLab with Red Hat Developer Hub, we need to enable the autodiscovery
capabilities of this provider. Very useful to load our catalog with repositories already created in
our GitLab server. That requires to enable the `backstage-plugin-catalog-backend-module-gitlab-dynamic`
dynamic plugin provided by Red Hat Developer Hub.


  * Enable the dynamic plugin for ArgoCD by applying the following yaml to the dynamic plugins configuration (on anchor_01):

We will use a new ConfigMap to enable the dynamic plugins:

```yaml
kind: ConfigMap
apiVersion: v1
metadata:
  name: dynamic-plugins-rhdh
data:
  dynamic-plugins.yaml: |
    includes:
      - dynamic-plugins.default.yaml
    plugins:
      - package: './dynamic-plugins/dist/backstage-plugin-catalog-backend-module-gitlab-dynamic'
        disabled: false
```

Add this to the `app-config-rhdh` ConfigMap:

```yaml
catalog:
  providers:
    gitlab:
      myGitLab:
        host: gitlab.${basedomain} # Identifies one of the hosts set up in the integrations
        apiBaseUrl: https://gitlab.${basedomain}/api/v4
        branch: main # Optional. Used to discover on a specific branch
        fallbackBranch: master # Optional. Fallback to be used if there is no default branch configured at the Gitlab repository. It is only used, if `branch` is undefined. Uses `master` as default
        skipForkedRepos: false # Optional. If the project is a fork, skip repository
        entityFilename: catalog-info.yaml # Optional. Defaults to `catalog-info.yaml`
        projectPattern: '[\s\S]*' # Optional. Filters found projects based on provided patter. Defaults to `[\s\S]*`, which means to not filter anything
        schedule: # optional; same options as in TaskScheduleDefinition
          # supports cron, ISO duration, "human duration" as used in code
          frequency: { minutes: 1 }
          # supports ISO duration, "human duration" as used in code
          timeout: { minutes: 3 }
```

Update the Red Hat Developer Hub manifest to use the new ConfigMap for plugins:

```yaml
spec:
  application:
  ...
    dynamicPluginsConfigMapName: dynamic-plugins-rhdh
```

## Enable users/teams autodiscovery

The Red Hat Developer Hub catalog can be set up to ingest organizational data -- users and groups -- directly from GitLab.
The result is a hierarchy of User and Group entities that mirrors your org setup.

Once we have integrated GitLab with Red Hat Developer Hub, we need to enable the autodiscovery
capabilities of users and groups. That requires to enable the `backstage-plugin-catalog-backend-module-gitlab-org-dynamic`
dynamic plugin provided by Red Hat Developer Hub.

```yaml
kind: ConfigMap
apiVersion: v1
metadata:
  name: dynamic-plugins-rhdh
data:
  dynamic-plugins.yaml: |
    includes:
      - dynamic-plugins.default.yaml
    plugins:
      # Other dynamic plugins
      - package: './dynamic-plugins/dist/backstage-plugin-catalog-backend-module-gitlab-org-dynamic'
        disabled: false
```

Add this to the ConfigMap:

```yaml
  catalog:
    providers:
      gitlab:
        myGitLab:
          host: gitlab.${basedomain}
          # ... previous GitLab configuration
          orgEnabled: true
          #group: org/teams # Required for gitlab.com when `orgEnabled: true`. Optional for self managed. Must not end with slash. Accepts only groups under the provided path (which will be stripped)
          allowInherited: true # Allow groups to be ingested even if there are no direct members.
          groupPattern: '[\s\S]*'
          restrictUsersToGroup: false
```

**NOTE**: Currently the GitLab resolver creates the users using the `id` instead of the `username`.
This matching impacts the references creates in the catalog to identify clearly the users and its groups.
There are some JIRA issues to improve that behavior. Meanwhile, to avoid issues in the rest of the
exercises, please register the next reference as components using the Red Hat Developer Hub UI.

[Users and Groups](https://github.com/rmarting/rhdh-exercises/blob/main/lab-prep/users-groups.yaml)
