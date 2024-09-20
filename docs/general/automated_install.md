---
layout: default
title: Automated Installation Script
---

# Automated Installation Script

When you would like to have an OpenShift cluster with all integrations configured automatically for you, you can make use of the
[script_init_cluster.sh](script_init_cluster.sh) script.  
In order to do so, you'll have to follow these steps:
1. Make sure you have a running OpenShift cluster without a project name demo-project, as that's the one I will be using
   (or replace demo-project in this repository).
2. Copy and execute the 'oc login' command.
3. Make a fork of [this GitHub repository](https://github.com/maarten-vandeperre/dev-hub-test-demo), so that it is a part
   of your repository list (or create a new repository and copy the catalog-info.yaml file over). This file will enable some
   Developer Hub/Backstage components on catalog component level (e.g., CI, CD, Kubernetes topology viewer, ...).
4. Execute [script_init_cluster.sh](script_init_cluster.sh).