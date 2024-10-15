---
layout: default
title: Dynamic plugin enablement and deploy
---

# Dynamic plugin enablement and deploy
> Note: The Dynamic Plugin feature in Developer Hub is still under active development.  Features and tooling around dynamic plugin enablement are still subject to change.

In this phase new build targets will be added to the plugins, along with any necessary tweaks to the plugin code to get them working as a dynamic plugin.

#### Enablement Step 1

First prepare the [root](https://github.com/maarten-vandeperre/developer-hub-documentation/tree/ansible/dynamic-plugins-workspace/backstage/package.json) 
`package.json` file by updating the `devDependencies` section and add the `@janus-idp/cli` tool
(maybe check for updates first on the [npm registry](https://www.npmjs.com/package/@janus-idp/cli)):

```json
 "@janus-idp/cli": "^1.15.1",
```

The next job is to update the `scripts` section of the root `package.json` files for the repo to add the `export-dynamic-plugin` command.

#### Enablement Step 2

Add the following to the `scripts` section of `plugins/simple-chat-backend/package.json`:

```json
"export-dynamic": "janus-cli package export-dynamic-plugin"
```

#### Enablement Step 3

Add the following to the `scripts` section of `plugins/simple-chat/package.json`:

```json
"export-dynamic": "janus-cli package export-dynamic-plugin"
```

#### Enablement Step 4

Update the root `package.json` file to make it easy to run the `export-dynamic` command from the root of the repository by 
adding one of the following to the `scripts` section:

##### using yarn v1

> Note: If running this on Windows, either use WSL (or similar) or adjust this command

```json
"export-dynamic": "yarn --cwd plugins/simple-chat-backend export-dynamic && yarn --cwd plugins/simple-chat export-dynamic"
```

##### using yarn v3+

```json
"export-dynamic": "yarn workspaces foreach -A run export-dynamic"
```

Also update the `.gitignore` file at this point to ignore `dist-dynamic` directories:

```text
dist-dynamic
```

#### Enablement Step 5

The backend as generated needs a couple tweaks to work as a dynamic plugin, as the generated code relies on a component imported from `@backstage/backend-defaults`.  Update `plugins/simple-chat-backend/src/service/router.ts` to remove this import:

```typescript
import { MiddlewareFactory } from '@backstage/backend-defaults/rootHttpRouter';
```

and add this import instead:

```typescript
import { MiddlewareFactory } from '@backstage/backend-app-api';
```

These correspond to the versions of the packages released with Backstage 1.26.5.

#### Enablement Step 6

The frontend plugin has it's own icon in the main navigation which needs to be exported.  Update `plugins/simple-chat/src/index.ts` to re-export the `ChatIcon` from `@backstage/core-components` from the plugin so it can be referenced in the configuration.  Do this by updating `plugins/simple-chat/src/index.ts` to look like:

```typescript
import { ChatIcon as ChatIconBackstage } from '@backstage/core-components';
export { simpleChatPlugin, SimpleChatPage } from './plugin';
export const ChatIcon = ChatIconBackstage;
```

#### Enablement Step 7

Finally, the frontend plugin should include some basic configuration so that it will be visible in the Developer Hub app.  The convention currently is to put this into an `app-config.janus-idp.yaml` file.  Create the file `plugins/simple-chat/app-config.janus-idp.yaml` and add the following:

```yaml
    dynamicPlugins:
      frontend:
        internal.backstage-plugin-simple-chat:
          appIcons:
          - name: chatIcon
            importName: ChatIcon
          dynamicRoutes:
          - path: /simple-chat
            importName: SimpleChatPage
            menuItem:
              text: 'Simple Chat'
              icon: chatIcon
```

While this is not currently used by any of the tooling, this still serves as a reference for plugin installers.

The results of all of these changes along with the additions discussed in the deployment phase are available in [this commit](https://github.com/gashcrumb/dynamic-plugins-getting-started/commit/08b637454f437d0c5a1f4185d8abfb2e0b84d83d)

### Phase 4 - Dynamic Plugin Deployment

> Note: The Dynamic Plugin feature in Developer Hub is still under active development.  Features regarding plugin deployment are still being defined and developed.  The method shown here is one method that doesn't involve using an NPM registry to host plugin static assets.

Deploying a dynamic plugin to Developer Hub involves exporting a special build of the plugin and packing it into a `.tar.gz` file.  Once the dynamic plugins are exported as `.tar.gz` to a directory, that directory will be used to create an image, which will then be served by an `httpd` instance in OCP.  Deployment in Developer Hub is still in a technical preview phase, so there's not much tooling to help.  Some scripts mentioned in the last phase have been added to this repo to hopefully make this process straightforward.

#### Deployment Step 1

Create a directory to put the `.tar.gz` files into called `deploy` and add a `.gitkeep` file to it.
```text
mkdir deploy && touch deploy/.gitkeep
```

Update the `.gitignore` file as well to ignore `.tar.gz` files:

```text
deploy/*.tgz
```

#### Deployment Step 2

Make sure to build everything at this point, often it's easiest to run a chain of commands from the root of the repo like:

```text
yarn install && yarn run tsc && yarn run build:all && yarn run export-dynamic
```

Download script files:

```bash
curl --output 01-stage-dynamic-plugins.sh  https://raw.githubusercontent.com/gashcrumb/dynamic-plugins-getting-started/main/01-stage-dynamic-plugins.sh
```

```bash
curl --output 02-create-plugin-registry.sh  https://raw.githubusercontent.com/gashcrumb/dynamic-plugins-getting-started/main/02-create-plugin-registry.sh
```

```bash
curl --output 03-update-plugin-registry.sh  https://raw.githubusercontent.com/gashcrumb/dynamic-plugins-getting-started/main/03-update-plugin-registry.sh
```

And then use the `01-stage-dynamic-plugins.sh` script to pack the plugins into `.tar.gz` files and display their integrity hashes:

```bash
bash ./01-stage-dynamic-plugins.sh
```

The output should look kind of like:

```text
Packaging up plugin static assets

Backend plugin integrity Hash: sha512-mwHcJV0Gx6+GHuvqxpJsw9Gzn/8H5AjoGQ2DlMY4ntntAhdpFr/o5IZO5bOri41R14ocDg3KUqDxaZY/4AWSLg==
Frontend plugin integrity Hash: sha512-t5HcciQFHsaSjjkiV5Ri1XqAsww9pdJy5zRRrOv8ddGdK1VXGe1ec2+WyDSkguZz1y3UDdaK3mW7asRanWXFOQ==

Plugin .tgz files:
total 3756
-rw-r--r--. 1 gashcrumb gashcrumb 1575584 Jul  3 14:55 internal-backstage-plugin-simple-chat-backend-dynamic-0.1.0.tgz
-rw-r--r--. 1 gashcrumb gashcrumb 2266355 Jul  3 14:55 internal-backstage-plugin-simple-chat-dynamic-0.1.0.tgz
```

Make note of or copy the integrity hashes, as these will be needed later when configuring Developer Hub on OpenShift.

#### Deployment Step 3

Now that the files are ready to deploy a new build can be created on OpenShift.  Make sure to use `oc project` to first switch the the same project that Developer Hub is running in.  Use the `02-create-plugin-registry.sh` script to create the build, start it and then start a new app using the built image stream:

```bash
bash ./02-create-plugin-registry.sh
```

Once the script is complete, have a look in the OpenShift console Topology view and there should be a new app running called "plugin-registry".

#### Deployment Step 4

Create a custom configuration for Developer Hub called `app-config-rhdh` by creating a new `ConfigMap` with the following contents, however update the `baseUrl` and `origin` settings shown as needed:

> IT IS INCREDIBLY IMPORTANT THAT THE URLS IN THIS CONFIGURATION ARE CORRECT!!!

```yaml
kind: ConfigMap
apiVersion: v1
metadata:
  name: app-config-rhdh
data:
  app-config-rhdh.yaml: |-

    app:
      title: Red Hat Developer Hub - Getting Started
      # Be sure to use the correct url here, the URL given is an example
      baseUrl: https://backstage-developer-hub-example.apps-crc.testing
    backend:
      baseUrl: https://backstage-developer-hub-example.apps-crc.testing
      cors:
        origin: https://backstage-developer-hub-example.apps-crc.testing

    auth:
      environment: development
      providers:
        guest:
          dangerouslyAllowOutsideDevelopment: true
    dynamicPlugins:
      frontend:
        internal.backstage-plugin-simple-chat:
          appIcons:
            - name: chatIcon
              importName: ChatIcon
          dynamicRoutes:
            - path: /simple-chat
              importName: SimpleChatPage
              menuItem:
                text: 'Simple Chat'
                icon: chatIcon
```

#### Deployment Step 5

Create a custom dynamic plugin configuration for Developer Hub called `dynamic-plugins-rhdh` by creating another `ConfigMap` with the following contents, however be sure to update the integrity hashes to match the ones printed out by the `01-stage-dynamic-plugins.sh` script:

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
      - package: 'http://plugin-registry:8080/internal-backstage-plugin-simple-chat-backend-dynamic-0.1.0.tgz'
        disabled: false
        integrity: 'sha512-mwHcJV0Gx6+GHuvqxpJsw9Gzn/8H5AjoGQ2DlMY4ntntAhdpFr/o5IZO5bOri41R14ocDg3KUqDxaZY/4AWSLg=='
      - package: 'http://plugin-registry:8080/internal-backstage-plugin-simple-chat-dynamic-0.1.0.tgz'
        disabled: false
        integrity: 'sha512-t5HcciQFHsaSjjkiV5Ri1XqAsww9pdJy5zRRrOv8ddGdK1VXGe1ec2+WyDSkguZz1y3UDdaK3mW7asRanWXFOQ=='
```

__Watch out for the quotes!__

#### Deployment Step 6

Now update the operator `CustomResource` to load these two ConfigMaps as configuration for DeveloperHub:

```yaml
spec:
  application:
    appConfig:
      configMaps:
        - name: app-config-rhdh
      mountPath: /opt/app-root/src
    dynamicPluginsConfigMapName: dynamic-plugins-rhdh
    extraFiles:
      mountPath: /opt/app-root/src
    replicas: 1
    route:
      enabled: true
  database:
    enableLocalDb: true
```

At this point clicking `Save` should cause the operator to redeploy Developer Hub.  Wait patiently while OpenShift redeploys Developer Hub.

If everything has worked properly the new instance of Developer Hub should contain a "Simple Chat" entry in the sidebar with an icon, clicking on this entry should reveal the chat UI, and it should be possible to send chat messages and view those messages even after a page refresh.

#### Appendix

### Development Loop

If there's a need to rebuild the plugins and redeploy the existing scripts can be used.  The development loop at this point looks like:

Rebuild everything:

```bash
yarn install && yarn run tsc && yarn run build:all && yarn run export-dynamic
```

Stage the `.tar.gz` files:

```bash
bash ./01-stage-dynamic-plugins.sh
```

Update the image:

```bash
bash ./03-update-plugin-registry.sh
```

### Migrate generated app to Yarn v3

Out of the box the `create-app` command sets up a Yarn v1 project, which quickly becomes troublesome as this version is almost unmaintained.  A good option is to migrate the project to Yarn v3 as discussed in the Backstage documentation [here](https://backstage.io/docs/tutorials/yarn-migration/).  This project has been migrated to use Yarn v3 now.

### Using a container image for local development

> Note: While it is possible to run Red Hat Developer Hub outside of Openshift using podman for local development purposes, this method of running Developer Hub is not currently supported for production deployments; only a Red Hat Developer Hub instance installed via the Helm chart or operator is supported for production usage

It's possible to run the RHDH container locally and is handy for developing dynamic plugin.  First extract each .tgz file under the `deploy` directory, each time rename the `package` directory to the plugin name.  Then remove the .tgz files, so the contents of the deploy directory would look like:

```text
internal-backstage-plugin-simple-chat-backend-dynamic
internal-backstage-plugin-simple-chat-dynamic
```

Then use the `appendix-run-container.sh` script to start Developer Hub:

```bash
bash ./appendix-run-container.sh
```

The app should be available at http://localhost:7007 and the Simple Chat plugin should be loaded and available on the sidebar after logging in as guest.