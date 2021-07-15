Tatoru::Client.configure do |config|
  # Configure your region here.
  #
  # Available regions are:
  #
  # * eu
  # * staging-eu
  #
  # default: config.region = ENV.fetch("TATORU_ANTIVIRUS_REGION", "eu")
  #
  config.region = ENV.fetch("TATORU_ANTIVIRUS_REGION", "eu")

  # Configure your api token here. You can get you api token by
  # visiting https://www.tatoru.io/en/auth/user
  #
  # default: config.api_token = ENV.fetch("TATORU_ANTIVIRUS_API_TOKEN", "<your-api-token>")
  #
  config.api_token = ENV.fetch("TATORU_ANTIVIRUS_API_TOKEN", "<your-api-token>")
end
