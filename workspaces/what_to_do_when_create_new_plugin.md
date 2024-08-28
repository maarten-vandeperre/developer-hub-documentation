# Steps to take
1. Go to plugin root (e.g., workspace > dynamic-plugin-1 > dynamic-plugin-1).
2. Run 'yarn new' and select the type of plugin you want.
3. Go to plugins sub folder and select the plugin sub folders you want to edit.
   1. Add the following to the scripts package.json: '"export-dynamic": "janus-cli package export-dynamic-plugin"'.
4. Go to the root package.json (e.g., workspace > dynamic-plugin-1 > dynamic-plugin-1) and add
the new plugin folder to the 'export-dynamic' script.
5. From the root folder, run 'yarn install && yarn run tsc && yarn run build:all && yarn run export-dynamic' 
or for a custom action 'janus-cli package export-dynamic-plugin --embed-package @backstage/plugin-scaffolder-backend-module-github --override-interop default --no-embed-as-dependencies'.
6. Run 'npm pack plugins/scaffolder-backend-module-custom-action-argocd-create-resources/dist-dynamic --pack-destination ./deploy --json | jq -r '.[0].integrity'' 
in order to generate the first tar.gz file. (Be aware to change the plugin directory).
7. Go to workspace > scripts > plugin-building
   1. Change '01-stage-dynamic-plugins.sh' by adding the new plugin's hash.
   2. Change 'update_hashes_in_dyn_plugins_yaml.sh' by adding the new plugin's hash.
8. Add a plugin in gitops > developer-hub > 21_dynamic-plugins-rhdh.yaml with a default hash value and as name the name of the resulting
tar file in workspace > dynamic-plugin-1 > dynamic-plugin-1 > deploy