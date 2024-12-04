---
layout: default
title: Enable Component scanning (i.e., catalog entity)
---

# Enable Component scanning (i.e., catalog entity)

In order to enable software templates (for GitHub), the only thing you'll need to do, is configuring a GitHub application that has the permission to
create Git repositories (see [How to configure GitHub applications](https://maarten-vandeperre.github.io/developer-hub-documentation/github/token_configurations.html)).

Make sure you have the values for the following fields:
* Personal Access Token (not GitHub application related, but user bound).
* Application ID
* Application's Client ID
* Application's Client Secret
* Application's Private Key

If you are not making use of the script_init_cluster script, you will need to add it to a config map.
A config map template can be found in secrets/raw/secret_github_integration. If you make use of the
script_init_cluster script, then it will be asked upon startup (and be places in the secrets/generated folder).

Now that we have the values in our config map, we'll need to add the config map to the developer hub instance definition
configuration like this (_rhdh-secrets should already be there_):

```yaml
  secrets:
    - name: rhdh-secrets # added
    - name: rhdh-secrets-github-integration
```

Now, add a GitHub integration configuration by applying the following yaml to the Developer Hub Config on anchor_02:
```yaml
integrations:
  github:
    - host: github.com
      token: ${RHDH_GITHUB_INTEGRATION_PERSONAL_ACCESS_TOKEN}
      apps:
        - appId: ${RHDH_GITHUB_INTEGRATION_APP_ID}
          clientId: ${RHDH_GITHUB_INTEGRATION_APP_CLIENT_ID}
          clientSecret: ${RHDH_GITHUB_INTEGRATION_APP_CLIENT_SECRET}
          webhookUrl: none
          webhookSecret: none
          privateKey: ${RHDH_GITHUB_INTEGRATION_APP_PRIVATE_KEY}
```
_Note: I am adding the personal access token over here, mainly because I am lazy. You can make it a part of the software template's input parameters as well.
Difference in between the two solutions: in this solution you'll need some kind of system user account to be bound to developer hub, if you ask it in the
software template, it will be bound to the user who initiated the template._

If you want to see it in a complete configuration file, feel free to have a look at [gitops/developer-hub/11_app-config-rhdh.yaml](https://github.com/maarten-vandeperre/developer-hub-documentation/tree/main/gitops/developer-hub/11_app-config-rhdh.yaml),
which contains all the integrations, described in this README file.

Now we need to add the software template, for this we will go to the "create..." menu item and
follow the following steps:
1. Click on the button "Register Existing Component".
2. Fill the following URL and click analyze: [https://github.com/maarten-vandeperre/developer-hub-documentation/tree/main/configurations/software-templates/simple-hello-world/template.yaml](https://github.com/maarten-vandeperre/developer-hub-documentation/tree/main/configurations/software-templates/simple-hello-world/template.yaml).

   ![GtiHub]({{site.url}}/assets/images/github/software-template-1.png)

3. Click "refresh" button.
4. No need to click "Register another", you can just click the "create..." menu item again
   and the template should be visible now:

   ![GtiHub]({{site.url}}/assets/images/github/software-template-2.png)

**A software template is defined by**
* A GitHub (submodule in) repository. In my example: [https://github.com/maarten-vandeperre/developer-hub-documentation/tree/main/configurations/software-templates/simple-hello-world](https://github.com/maarten-vandeperre/developer-hub-documentation/tree/main/configurations/software-templates/simple-hello-world).
* A template.yaml file which defines the catalog entity type "Template"
  (See section [Define the catalog entities](https://maarten-vandeperre.github.io/developer-hub-documentation/catalog_entities/dev_hub_catalog_entities_manually.html#define-the-catalog-entities)).
* Most of the time a skeleton folder (unless defined differently in the template.yaml file),
  which contains the source code. This code can be parameterized: check e.g., skeleton/catalog-info.yaml,
  which is using the name and owner field, which are defined in the template.yaml file and initiated during
  template initiation.

**Initiating the software template**
When you have the catalog with the templates, pick the template you want to initiate and
click "Choose".

![GtiHub]({{site.url}}/assets/images/github/software-template-3.png)

Now you can initiate the template. I use the following values:
* Repository name: dev-hub-test-demo
* Name: dev-hub-test-demo
* Owner: maarten-vandeperre-org

Click "Review" and click "Create", and you should be able to see the link to the new repository
or you will see it in GitHub:

![GtiHub]({{site.url}}/assets/images/github/software-template-4.png)

![GtiHub]({{site.url}}/assets/images/github/software-template-5.png)
