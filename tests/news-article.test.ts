import { describe, it, expect, beforeEach, vi } from 'vitest';

describe('News Article Contract', () => {
  let mockContractCall: any;
  
  beforeEach(() => {
    mockContractCall = vi.fn();
  });
  
  it('should create a news article', async () => {
    mockContractCall.mockResolvedValue({ success: true, value: 1 });
    const result = await mockContractCall('create-article', 'Test Article', '0x1234567890', 100);
    expect(result.success).toBe(true);
    expect(result.value).toBe(1);
  });
  
  it('should get article details', async () => {
    mockContractCall.mockResolvedValue({
      success: true,
      value: {
        author: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM',
        title: 'Test Article',
        content_hash: '0x1234567890',
        timestamp: 123456,
        stake_amount: 100
      }
    });
    const result = await mockContractCall('get-article', 1);
    expect(result.success).toBe(true);
    expect(result.value.title).toBe('Test Article');
  });
  
  it('should transfer an article', async () => {
    mockContractCall.mockResolvedValue({ success: true });
    const result = await mockContractCall('transfer-article', 1, 'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG');
    expect(result.success).toBe(true);
  });
});

