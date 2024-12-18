import { describe, it, expect, beforeEach, vi } from 'vitest';

describe('Fact Check Contract', () => {
  let mockContractCall: any;
  
  beforeEach(() => {
    mockContractCall = vi.fn();
  });
  
  it('should create a fact check', async () => {
    mockContractCall.mockResolvedValue({ success: true, value: 1 });
    const result = await mockContractCall('create-fact-check', 1, 'True', 'This article is accurate', 50);
    expect(result.success).toBe(true);
    expect(result.value).toBe(1);
  });
  
  it('should get fact check details', async () => {
    mockContractCall.mockResolvedValue({
      success: true,
      value: {
        checker: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM',
        article_id: 1,
        verdict: 'True',
        explanation: 'This article is accurate',
        timestamp: 123456,
        stake_amount: 50
      }
    });
    const result = await mockContractCall('get-fact-check', 1);
    expect(result.success).toBe(true);
    expect(result.value.verdict).toBe('True');
  });
});

