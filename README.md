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
require 'microsoft-live/client'
client = MicrosoftLive::Client.new(
  client_id: ENV['CLIENT_ID'],
  client_secret: ENV['CLIENT_SECRET'],
  access_token: '...',
  refresh_token: '...',
  expires_at: ...
)
```

## LICENSE

This software is released under the Apache License, version 2.0. A copy of the license is included with this software.
