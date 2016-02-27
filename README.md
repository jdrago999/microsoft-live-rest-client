# microsoft-live-simple

## INSTALLATION

In your `Gemfile`:

```ruby
gem 'microsoft-live-simple', github: 'jdrago999/microsoft-live-simple'
```

## DESCRIPTION

A simple client to the Microsoft "Live" REST API.

Designed to worth with the OAuth2.0 tokens retrieved by https://github.com/jdrago999/omniauth-microsoft-live

## RATIONALE

I couldn't find one that already existed.

## SYNOPSIS

```ruby
require 'microsoft-live'

MicrosoftLive.configure do |config|
  config.client_id = ENV['CLIENT_ID']
  config.client_secret = ENV['CLIENT_SECRET']
  config.redirect_uri = ENV['REDIRECT_URI']
end

client = MicrosoftLive::Client.new(
  access_token: '...',
  refresh_token: '...',
  expires_at: ...
)

# NOTE: Your token is automatically refreshed when the old one expires.

result = client.contacts
contacts = [ ]
loop do
  break unless result.items

  all_contacts += result.items
  result = result.next_page
end

# Contact can reference a user:
user = contacts.first.user
```

## LICENSE

This software is released under the Apache License, version 2.0. A copy of the license is included with this software.

## SEE ALSO

  * https://msdn.microsoft.com/en-us/library/hh243648.aspx
  * https://msdn.microsoft.com/en-us/library/hh243649.aspx#refresh_rest
