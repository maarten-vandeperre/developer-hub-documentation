import { Entity } from '@backstage/catalog-model';
export const isSimpleChatPageAvailable = (entity: Entity): boolean => {
    console.info("these are annotations to check if the simple chat page is available", entity.metadata.annotations)
    return true;
}