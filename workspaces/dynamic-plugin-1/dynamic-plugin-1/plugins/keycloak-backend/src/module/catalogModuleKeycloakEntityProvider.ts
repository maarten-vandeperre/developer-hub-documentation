/*
 * Copyright 2023 The Janus IDP Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import {
  coreServices,
  createBackendModule,
} from '@backstage/backend-plugin-api';
import { catalogProcessingExtensionPoint } from '@backstage/plugin-catalog-node/alpha';

import { keycloakTransformerExtensionPoint } from '../extensions';
import { GroupTransformer, UserTransformer } from '../lib/types';
import { KeycloakOrgEntityProvider } from '../providers';

/**
 * Registers the `KeycloakEntityProvider` with the catalog processing extension point.
 *
 * @alpha
 */
export const catalogModuleKeycloakEntityProvider = createBackendModule({
  pluginId: 'catalog',
  moduleId: 'catalog-backend-module-keycloak',
  register(env) {
    let userTransformer: UserTransformer | undefined;
    let groupTransformer: GroupTransformer | undefined;

    env.registerExtensionPoint(keycloakTransformerExtensionPoint, {
      setUserTransformer(transformer) {
        if (userTransformer) {
          throw new Error('User transformer may only be set once');
        }
        userTransformer = transformer;
      },
      setGroupTransformer(transformer) {
        if (groupTransformer) {
          throw new Error('Group transformer may only be set once');
        }
        groupTransformer = transformer;
      },
    });
    env.registerInit({
      deps: {
        catalog: catalogProcessingExtensionPoint,
        config: coreServices.rootConfig,
        logger: coreServices.logger,
        scheduler: coreServices.scheduler,
      },
      async init({ catalog, config, logger, scheduler }) {
        catalog.addEntityProvider(
          KeycloakOrgEntityProvider.fromConfig(config, {
            id: 'development',
            logger,
            scheduler,
            userTransformer: userTransformer,
            groupTransformer: groupTransformer,
          }),
        );
      },
    });
  },
});
