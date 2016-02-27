require 'spec_helper'

describe MicrosoftLive::Simple do
  before do
    @client_id = SecureRandom.uuid
    @client_secret = SecureRandom.uuid
    @redirect_uri = 'https://example.com/%s' % SecureRandom.uuid
    MicrosoftLive.configure do |config|
      config.client_id = @client_id
      config.client_secret = @client_secret
      config.redirect_uri = @redirect_uri
    end

    simple = described_class.new(
      token: 'zzz',
      refresh_token: '123',
      expires_at: (Time.now + 30.seconds).to_i,
    )
  end
  it 'stores the credentials' do
  end
end

