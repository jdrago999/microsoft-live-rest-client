
require 'microsoft-live/simple'
module MicrosoftLive
  class InvalidConfigError < StandardError; end
  class NotConfiguredError < StandardError; end
  class << self
    attr_accessor :configuration, :did_configure
    @did_configure = false

    def reset_configuration!
      self.configuration = OpenStruct.new
      self.did_configure = false
    end

    def configure(&block)
      reset_configuration!
      block.call(self.configuration)
      configuration.client_id or raise InvalidConfigError.new 'config.client_id is required'
      configuration.client_secret or raise InvalidConfigError.new 'config.client_secret is required'
      configuration.redirect_uri or raise InvalidConfigError.new 'config.redirect_uri is required'
      self.did_configure = true
    end

    def config
      raise InvalidConfigError.new('Configuration not defined') unless self.did_configure
      self.configuration
    end
  end
end
