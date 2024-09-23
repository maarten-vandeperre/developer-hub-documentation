import {
  createPlugin,
  createRoutableExtension,
} from '@backstage/core-plugin-api';

import { rootRouteRef } from './routes';

export const simpleChatPlugin = createPlugin({
  id: 'simple-chat',
  routes: {
    root: rootRouteRef,
  },
});

export const SimpleChatPage = simpleChatPlugin.provide(
  createRoutableExtension({
    name: 'SimpleChatPage',
    component: () =>
      import('./components/ExampleComponent').then(m => m.ExampleComponent),
    mountPoint: rootRouteRef,
  }),
);
