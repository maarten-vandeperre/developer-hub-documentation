---
layout: default
title: Developer Hub Installation
---

# Developer Hub Installation

## Install Red Hat Developer Hub via operator
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
* _In our case: backstage-developer-hub-demo-project.apps.cluster-bnc5t.sandbox3269.opentlc.com_

## Install Red Hat Developer Hub via Helm chart
[Helm chart install guide](https://developers.redhat.com/learning/learn:openshift:install-and-configure-red-hat-developer-hub-and-explore-templating-basics/resource/resources:install-red-hat-developer-hub-developer-sandbox-red-hat-openshift)
