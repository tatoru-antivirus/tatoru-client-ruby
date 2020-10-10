require 'pry'

module Tatoru
  module Client
    class Node
      def initialize
        @configuration = Tatoru::Client::Configuration
      end

      def scan_url(url)
        httparty_options = [
          :post,
          "#{base_url}/scans",
          body: { scan: { url: url } },
          headers: {
            "Authorization" => "Bearer #{api_token}"
          }
        ]
        # puts httparty_options.inspect
        result = HTTParty.send(*httparty_options)

        if result.created?
          json = JSON.parse(result.body)
          # puts json
          json
        else
          raise Tatoru::Client::NodeError.new("HTTP error #{result.code} scanning #{url}: #{result.body}")
        end
      end

      def scan_file(file)
        httparty_options = [
          :post,
          "#{base_url}/scans",
          body: { scan: { asset: open(file) } },
          headers: { 
            "Authorization" => "Bearer #{api_token}",
          }
        ]
        # puts httparty_options.inspect
        result = HTTParty.send(*httparty_options)

        if result.created?
          json = JSON.parse(result.body)
          # puts json
          json
        else
          raise Tatoru::Client::NodeError.new("HTTP error #{result.code} scanning #{file}: #{result.body}")
        end
      end

      private

      def api_token
        @configuration.api_token
      end

      def base_url
        "https://#{@configuration.region}.tatoru.io"
      end
    end
  end
end
