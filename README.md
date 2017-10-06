[![Gem Version](https://badge.fury.io/rb/sesame-ruby.png)](http://badge.fury.io/rb/sesame-ruby)
[![Build Status](https://travis-ci.org/mbklein/sesame-ruby.svg?branch=master)](https://travis-ci.org/mbklein/sesame-ruby)
[![Coverage Status](https://coveralls.io/repos/mbklein/sesame-ruby/badge.svg?branch=master&service=github)](https://coveralls.io/github/mbklein/sesame-ruby?branch=master)

# Sesame

This gem provides a simple Ruby wrapper around the [CANDY HOUSE Sesame API](https://docs.candyhouse.co/) to control
Sesame Bluetooth and Internet-connected locks.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sesame-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sesame-ruby

## Usage

    # Log into the API
    > client = Sesame::Client.new(email: 'abc@i-lovecandyhouse.co', password: 'super-strong-password')
    => #<Sesame::Client:0x007fa1a81771d0 user: abc@i-lovecandyhouse.co>

    # Get an array of all API-enabled devices associated with the account
    > client.sesames
    => [#<Sesame::Sesame:0x007fa1aa3bb188 device_id: ABC1234567, nickname: Front door, is_unlocked: true, api_enabled: true, battery: 100>,
    #<Sesame::Sesame:0x007fa1aa3bb160 device_id: DEF7654321, nickname: Back door, is_unlocked: false, api_enabled: false, battery: 80>]

    # Get a single device
    > sesame = client.sesame(device_id: 'ABC1234567')
    => #<Sesame::Sesame:0x007fa1aa3bb188 device_id: ABC1234567, nickname: Front door, is_unlocked: true, api_enabled: true, battery: 100>

    # Control the device
    > sesame.unlock
    => true
    > sesame.lock
    => true

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0).
