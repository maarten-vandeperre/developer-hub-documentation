import React from 'react';
import { createDevApp } from '@backstage/dev-utils';
import { ansibleSelfServicePlugin, AnsibleSelfServicePage } from '../src/plugin';

createDevApp()
  .registerPlugin(ansibleSelfServicePlugin)
  .addPage({
    element: <AnsibleSelfServicePage />,
    title: 'Root Page',
    path: '/ansible-self-service',
  })
  .render();
