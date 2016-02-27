
require 'httparty'
require 'microsoft-live/collector'
require 'microsoft-live/contact'
require 'microsoft-live/user'
module MicrosoftLive
  class RenewTokenError < StandardError; end
  class ApiError < StandardError; end
  class Simple
    include HTTParty
    attr_accessor :client_id, :client_secret, :token, :refresh_token, :expires_at, :redirect_uri
    base_uri 'https://login.live.com/'

    def initialize(token:, refresh_token:, expires_at:)
      self.client_id = self.class.config.client_id
      self.client_secret = self.class.config.client_secret
      self.redirect_uri = self.class.config.redirect_uri
      self.token = token
      self.refresh_token = refresh_token
      self.expires_at = expires_at

      if Time.now.to_i > expires_at
        new_auth = renew_token
        self.token = new_auth.token
        self.refresh_token = new_auth.refresh_token
        self.expires_at = new_auth.expires_at
      end
    end

    def contacts
      ::MicrosoftLive::Collector.new(
        simple: self,
        path: '/me/contacts',
        offset: 0,
        limit: 50,
        item_class: ::MicrosoftLive::Contact
      )
    end

    def user(user_id)
      self.class.base_uri 'https://apis.live.net/v5.0'
      res = self.class.get('/%s' % user_id,
        headers: {
          'Authorization' => "Bearer #{token}"
        }
      )
      case res.code
      when 200
        data = JSON.parse(res.body, symbolize_names: true)
        ::MicrosoftLive::User.new(data: data, simple: self)
      else
        raise ApiError.new res.body
      end
    end

    def get_collection(url:, limit: 10, offset: 0)
      self.class.base_uri 'https://apis.live.net/v5.0'
      res = self.class.get('/%s?limit=%d&offset=%d' % [ url, limit, offset ],
        headers: {
          'Authorization' => "Bearer #{token}"
        }
      )
      case res.code
      when 200
        JSON.parse(res.body, symbolize_names: true)
      else
        raise ApiError.new res.body
      end
    end

    def renew_token
      res = self.class.post('/oauth20_token.srf',
        body: {
          client_id: client_id,
          redirect_uri: redirect_uri,
          client_secret: client_secret,
          refresh_token: refresh_token,
          grant_type: :refresh_token
        }
      )
      case res.code
      when 200
        data = JSON.parse(res.body, symbolize_names: true)
        OpenStruct.new(
          token: data[:access_token],
          refresh_token: data[:refresh_token],
          expires_at: Time.now.to_i + data[:expires_in]
        )
      else
        raise RenewTokenError.new res.body
      end
    end

  end
end
