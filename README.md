# Tatoru Anti Virus Client for ruby

A simple ruby client for remote anti virus scanning with tatoru.io.

## Usage with rails

See [tatoru-client-rails](https://github.com/tatoru-antivirus/tatoru-client-rails) if you are using rails.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'tatoru-client'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install tatoru-client
```

## Setup

Configure your api token and endpoint:

    irb> require 'tatoru-client'
    irb> Tatoru::Client.configure do |config|
    irb>   config.region = "eu"
    irb>   config.api_token = "<your-api-token>"
    irb> end

## Usage

Scanning a file:

    irb> Tatoru::Client::File.safe?("./some-clean-file.pdf")
    irb>   => true

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
