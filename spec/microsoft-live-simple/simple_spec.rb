require 'spec_helper'

describe MicrosoftLive::Simple do
  before do
    simple = described_class.new(
      token: 'zzz',
      refresh_token: '123',
      expires_at: (Time.now + 30.seconds).to_i,
    )
  end
  it 'stores the credentials' do
  end
end

