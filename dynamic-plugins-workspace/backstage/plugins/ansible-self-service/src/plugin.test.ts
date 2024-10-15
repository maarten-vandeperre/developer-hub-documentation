import { ansibleSelfServicePlugin } from './plugin';

describe('ansible-self-service', () => {
  it('should export plugin', () => {
    expect(ansibleSelfServicePlugin).toBeDefined();
  });
});
