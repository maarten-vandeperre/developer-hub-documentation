---
layout: default
title: Developer Hub Installation
---

# Developer Hub Installation

## Install Red Hat Developer Hub via operator

* Install the operator on OpenShift in the operator recommended namespace. This manifest can help on this:

```yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: rhdh-operator
---
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  labels:
    operators.coreos.com/rhdh.rhdh-operator: ""
  name: rhdh
  namespace: rhdh-operator
spec:
  channel: fast
  installPlanApproval: Automatic
  name: rhdh
  source: redhat-operators
  sourceNamespace: openshift-marketplace
  startingCSV: rhdh-operator.v1.3.1
---
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  annotations:
    olm.providedAPIs: Backstage.v1alpha1.rhdh.redhat.com
  name: rhdh-operator-b7vxs
  namespace: rhdh-operator
spec:
  upgradeStrategy: Default
```

* Apply the following yaml to deploy a Developer Hub instance:

```yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: demo-project
---
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

* Wait for status to become "Deployed". This command will show it:

```shell
oc get backstage developer-hub -o jsonpath='{.status.conditions[0].type}' -n demo-project
```

* Get the route to Developer Hub:

```shell
echo https://$(oc get route backstage-developer-hub -n demo-project -o jsonpath='{.spec.host}')
```

## Install Red Hat Developer Hub via Helm chart

Please, follow the [Helm chart install guide](https://docs.redhat.com/en/documentation/red_hat_developer_hub/1.3/html/installing_red_hat_developer_hub_on_openshift_container_platform/assembly-install-rhdh-ocp-helm)
