---
layout: default
title: Create frontend and backend plugin
---

# Create frontend and backend plugin

## Frontend plugin
The frontend plugin can now be bootstrapped.  Run `yarn new` and select `plugin`.  

<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/yarn_new_frontend_plugin.png">

When prompted for a name, specify `simple-chat` This will generate some starting frontend code and add this plugin as a dependency to `packages/app/package.json`.  
The `yarn new` script in this case will also update `packages/app/src/App.tsx` to define a new `Route` component for the new plugin.  

However a link to the plugin still needs to be added to the application's main navigation.  Do this by editing `packages/app/src/components/Root/Root.tsx` and adding a 
new `SidebarItem` underneath the existing entry for "Create...":

```typescript
 <SidebarItem icon={ChatIcon} to="simple-chat" text="Simple Chat" />
```
And add an import:
```typescript
 Import `ChatIcon` from '@backstage/core-components'
```
Once completed, the end result should look similar to [this TODO commit]().  
Do a rebuild with `yarn run tsc && yarn run build:all` and then the generated frontend plugin should be visible in the UI when running `yarn start` from the root of the repo.