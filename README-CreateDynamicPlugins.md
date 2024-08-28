https://github.com/gashcrumb/dynamic-plugins-getting-started
https://github.com/redhat-developer/red-hat-developer-hub-software-templates/tree/main/templates
https://github.com/arunhari82/backstage-azure-workitem-backend
https://github.com/arunhari82/backstage-plugin-azure-workitem-dynamic
https://github.com/ibolton336/backstage-mta-plugins








https://github.com/gashcrumb/dynamic-plugins-getting-started <== very good tutorial

https://itsromiljain.medium.com/the-best-way-to-install-node-js-npm-and-yarn-on-mac-osx-4d8a8544987a
nvm install --lts

https://yarnpkg.com/migration/guide
=> create-app 0.5.14
npx @backstage/create-app@0.5.14    !! I did had to revert to yarn 1.22.

sh ../../scripts/plugin-building/01-stage-dynamic-plugins.sh   => from plugin root


Packaging up plugin static assets

Backend plugin integrity Hash: sha512-RcqzJ3igMYm06HeLiIvJJm/4aeCnkAQYet6/aylb6UAxDzqidnPJ7crSrrYMYchseTNolneVrwhnPz+MUFsZBA==
Frontend plugin integrity Hash: sha512-XTYEgHvD21JuXL5oIBpiluS51UECdHtnBX5bxv8R49r+0szfjY2JPbablGODZHiVcdHpt/CevcOa5krBQphgDQ==

Plugin .tgz files:
total 6824
-rw-r--r--@ 1 mvandepe  staff   742434 Aug 22 12:41 internal-backstage-plugin-simple-chat-backend-dynamic-0.1.0.tgz
-rw-r--r--@ 1 mvandepe  staff  2745128 Aug 22 12:41 internal-backstage-plugin-simple-chat-dynamic-0.1.0.tgz

Make sure that plugin-registry service is there with port 8080


Now in catalog entity component sub menu

https://github.com/janus-idp/backstage-showcase/blob/main/showcase-docs/dynamic-plugins.md

mention new readme in the workspace folder