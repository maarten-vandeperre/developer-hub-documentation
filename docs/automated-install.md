---
layout: default
title: Automated Install
---

# Automated Install

If you would like to have an OpenShift cluster with all integrations configured automatically for you, you can use the `script_init_cluster.sh` script.

### Steps:
1. Ensure you have a running OpenShift cluster without a project named `demo-project`.
2. Copy and execute the `oc login` command.
3. Fork [this GitHub repository](https://github.com/maarten-vandeperre/dev-hub-test-demo) to your repository list or create a new repository and copy the catalog-info.yaml file over.
4. Execute the `script_init_cluster.sh`.


Next to that, there is the `scripts/script_prepare_repository.sh`, which will configure all URLs to be pointing to your OpenShift environment
(after oc login was executed).
