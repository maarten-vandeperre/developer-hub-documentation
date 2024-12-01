# Enable RBAC

Enable permissions by updating `app-config-rhdh` ConfigMap:

```yaml
permission:
  enabled: true
  rbac:
    admin:
      users:
        - name: user:default/1
    policies-csv-file: /opt/app-root/src/rbac-policy.csv
```

Mount the new file in the `Backstage` manifests:

```yaml
    extraFiles:
      mountPath: /opt/app-root/src
      configMaps:
        - name: rbac-policy
          key: rbac-policy.csv
```

Create a new permission file, see [`rbac-policy-configmap-5.yaml`](./custom-app-config-gitlab/rbac-policy-configmap-5.yaml) file.

There is a dynamic plugin to allow manage the RBAC rules directly in the UI. This plugin is added in the list of the dynamic plugins
to add into Red Hat Developer Hub.

```sh
oc apply -f ./custom-app-config-gitlab/dynamic-plugins-5.yaml -n rhdh-gitlab
oc apply -f ./custom-app-config-gitlab/rbac-policy-configmap-5.yaml -n rhdh-gitlab
oc apply -f ./custom-app-config-gitlab/rhdh-app-configmap-5.yaml -n rhdh-gitlab
oc apply -f ./custom-app-config-gitlab/rhdh-instance-5.yaml -n rhdh-gitlab
```

Open an incognito window, or just logout, and login with `user2` (password: `@abc1cde2`) to confirm
that the component `sample-service` is not accessible on the `Catalog` page. You can check that
the `user1` can still access to that component successfully.

**NOTE**: If you login with the `root` user, you will be able to edit the RBAC policies from the `Administration` page.

References:

* [RBAC in Red Hat Developer Hub](https://docs.redhat.com/en/documentation/red_hat_developer_hub/1.2/html/administration_guide_for_red_hat_developer_hub/con-rbac-overview_assembly-rhdh-integration-aks)
