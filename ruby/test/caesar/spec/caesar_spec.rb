require 'spec_helper'

describe '#caesar_cipher' do
  it 'returns correct offset for a,3' do
    cipher = caesar_cipher('a', 3)
    expect(cipher).to eq 'd'
  end
  
  it 'should handle uppercase letters' do
    cipher = caesar_cipher('A', 3)
    expect(cipher).to eq 'D'
  end

  it 'should handle upper and lower case together' do
    cipher = caesar_cipher('Hello World', 3)
    expect(cipher).to eq 'Khoor Zruog'
  end

  it 'should not change letters with 0 offset' do
    cipher = caesar_cipher('a', 0)
    expect(cipher).not_to eq 'b'
  end

  it 'should return to start after z' do
    cipher = caesar_cipher('zZ', 2)
    expect(cipher).to eq 'bB'
  end
end
