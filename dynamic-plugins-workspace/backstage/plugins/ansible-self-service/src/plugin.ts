import {
  createPlugin,
  createRoutableExtension,
} from '@backstage/core-plugin-api';

import { rootRouteRef } from './routes';

export const ansibleSelfServicePlugin = createPlugin({
  id: 'ansible-self-service',
  routes: {
    root: rootRouteRef,
  },
});

export const AnsibleSelfServicePage = ansibleSelfServicePlugin.provide(
  createRoutableExtension({
    name: 'AnsibleSelfServicePage',
    component: () =>
      import('./components/ExampleComponent').then(m => m.ExampleComponent),
    mountPoint: rootRouteRef,
  }),
);
