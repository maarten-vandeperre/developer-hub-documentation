#!/bin/bash


#executed from the plugin root directory


yarn install && yarn run tsc && yarn run build:all && yarn run export-dynamic

sh ../../scripts/plugin-building/01-stage-dynamic-plugins.sh
sh ../../scripts/plugin-building/03-update-plugin-registry.sh

sh ../../scripts/plugin-building/update_hashes_in_dyn_plugins_yaml.sh

oc apply -f ../../../gitops/developer-hub/21_dynamic-plugins-rhdh.yaml