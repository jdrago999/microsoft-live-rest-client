require 'spec_helper'

describe MicrosoftLive do
  describe '.configure' do
    before do
      @client_id = SecureRandom.uuid
      @client_secret = SecureRandom.uuid
      @redirect_uri = 'https://example.com/%s' % SecureRandom.uuid
      described_class.configure do |config|
        config.client_id = @client_id
        config.client_secret = @client_secret
        config.redirect_uri = @redirect_uri
      end
    end
    it 'sets the client_id' do
      expect(described_class.config.client_id).to eq @client_id
    end
    it 'sets the client_secret' do
      expect(described_class.config.client_secret).to eq @client_secret
    end
    it 'sets the redirect_uri' do
      expect(described_class.config.redirect_uri).to eq @redirect_uri
    end
  end
end
