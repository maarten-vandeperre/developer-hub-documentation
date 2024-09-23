import React from 'react';
import { createDevApp } from '@backstage/dev-utils';
import { simpleChatPlugin, SimpleChatPage } from '../src/plugin';

createDevApp()
  .registerPlugin(simpleChatPlugin)
  .addPage({
    element: <SimpleChatPage />,
    title: 'Root Page',
    path: '/simple-chat',
  })
  .render();
