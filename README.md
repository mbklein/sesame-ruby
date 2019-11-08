[![Gem Version](https://badge.fury.io/rb/sesame-ruby.svg)](https://badge.fury.io/rb/sesame-ruby)
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

Please create the your auth token by logging into the [CANDY HOUSE Dashboard](https://my.candyhouse.co/) with your CANDY HOUSE account.

    > client = Sesame::Client.new(auth_token: 'your_auth_token')
    => #<Sesame::Client:0x007fa1a81771d0>

    # Get an array of all devices associated with the account
    > client.sesames
    => [#<Sesame::Sesame:0x007fa1aa3bb188 device_id: ABC1234567>,
    #<Sesame::Sesame:0x007fa1aa3bb160 device_id: DEF7654321>]

    # Get a single device
    > sesame = client.sesame(device_id: 'ABC1234567')
    => [#<Sesame::Sesame:0x007fa1aa3bb188 device_id: ABC1234567>

    # Control the device
    > sesame.unlock
    => true
    > sesame.lock
    => true

    # Show the device status
    > sesame.locked?
    => true
    > sesame.battery
    => 100

    # Sync the device status
    > sesame.refresh!
    => [#<Sesame::Sesame:0x007fa1aa3bb188 device_id: ABC1234567>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0).
