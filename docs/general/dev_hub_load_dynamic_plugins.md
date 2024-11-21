# Deploy a dynamic plugin

Another capability of Red Hat Developer Hub is add dynamic plugins easily. This exercise will deploy a dynamic
plugin defined in this [repo](https://github.com/rmarting/rhdh-dynamic-devquote-plugin)

Previously we added the definition of the GitLab catalog backend plugin, now we will extend the list of dynamic
plugins including the new one with the following configuration:

```yaml
    plugins:
      - package: './dynamic-plugins/dist/backstage-plugin-catalog-backend-module-gitlab-dynamic'
        disabled: false
      - package: './dynamic-plugins/dist/janus-idp-backstage-plugin-rbac'
        disabled: false
      - package: '@rmarting/my-devquote-plugin@0.0.2'
        integrity: sha512-S/CbM8s8vqVMeBeWGJ/4SsCd2b6K8Ngp992H1JN6HdwB9QiupPZu5wfnEpjN024SJemd/VUFT53tiUGrt1J/dw==
        disabled: false
        pluginConfig:
          dynamicPlugins:
            frontend:
              rmarting.my-devquote-plugin:
                mountPoints:
                  - config:
                      layout:
                        gridColumnEnd:
                          lg: span 4
                          md: span 6
                          xs: span 12
                    importName: DevQuote
                    mountPoint: entity.page.overview/cards
                dynamicRoutes:
                  - importName: DevQuote
                    menuItem:
                      text: Quote
                    path: /devquote
```

Or run:

```sh
oc apply -f ./custom-app-config-gitlab/dynamic-plugins-7.yaml -n rhdh-gitlab
```

Verify the `Quote` menu is listed, and a quote is showed in any component dashboard.
