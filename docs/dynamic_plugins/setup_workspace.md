---
layout: default
title: Setup workspace for dynamic plugins
---

# Setup workspace for dynamic plugins
In this section, I am going to describe how you can get started with the creation of dynamic plugins.
For this, I will base myself upon [this repository](https://github.com/gashcrumb/dynamic-plugins-getting-started).

> **Note: The Dynamic Plugin functionality is a tech preview feature of Red Hat Developer Hub and is still under active development. 
> Aspects of developing, packaging and deployment of dynamic plugins are subject to change**
> 

## Prerequisites
* node 20.x (node 18 may work fine also but untested) (20.17.0 was used during development)
* npm (10.8.2 was used during development)
* yarn (1.22.22 was used during initial development
* jq 
* oc

The commands used for deployment were developed with the bash shell in mind on Linux, 
some steps may require adjustment when trying this on a Windows environment. 
This guide will try and highlight these cases, though probably WSL would work also (but hasn't been tested).

## Bootstrap the project

### Step 0
Go to the folder that you want to use as your dynamic plugin workspace. For me, this will be 
[dynamic-plugins-workspace](https://github.com/maarten-vandeperre/developer-hub-documentation/tree/ansible/dynamic-plugins-workspace). 
!!! Be aware, when you will be checking this repository, it will already contain content as this will be my base workspace folder for custom
plugin development.

Now, go to the folder of interest, for me it is:
```shell
cd dynamic-plugins-workspace
```

### Step 1
Create a new Backstage app using a version of `create-app` that correlates to the Backstage version that the target Developer Hub is running.  There is a little matrix of versions to be aware of:

```text
RHDH 1.1 -> Backstage 1.23.4 -> create-app 0.5.11
RHDH 1.2 -> Backstage 1.26.5 -> create-app 0.5.14 
RHDH 1.3 -> Backstage 1.29.2 -> create-app 0.5.17 
```

How to resolve these versions?
* Start with the release notes documentation for Developer Hub
  * [Release notes version 1.2](https://docs.redhat.com/en/documentation/red_hat_developer_hub/1.2/html/release_notes_for_red_hat_developer_hub_1.2/pr01)
  * [Release notes version 1.3](https://docs.redhat.com/en/documentation/red_hat_developer_hub/1.3/html/release_notes/pr01)
* Then go the changelogs in the [Backstage release notes](https://github.com/backstage/backstage/tree/master/docs/releases) to find the create-app version.
  * [Changelogs for backstage 1.26.0](https://github.com/backstage/backstage/blob/master/docs/releases/v1.26.0-changelog.md)  
  _You'll find @backstage/create-app@0.5.14 in here_
  * [Changelogs for backstage 1.29.0](https://github.com/backstage/backstage/blob/master/docs/releases/v1.29.0-changelog.md)  
    _You'll find @backstage/create-app@0.5.17 in here_

So for Developer Hub 1.2 run:
```cli
npx @backstage/create-app@0.5.14
```
And for Developer Hub 1.3 run:
```cli
npx @backstage/create-app@0.5.17
```

You will need to give the app a name, I will use the default 'backstage'.
After prompting for a project name the `create-app` command will generate a git repo with the backstage app code.

you can now add it to git 
```shell
git add .
git commit -m "start on dynamic plugin development"
```