require 'pry'

module Tatoru
  module Client
    class Node
      def initialize
        @configuration = Tatoru::Client::Configuration
      end

      def status
        httparty_options = [
          :get,
          "#{base_url}/status",
          headers: {
            "Authorization" => "Bearer #{api_token}"
          }
        ]

        result = HTTParty.send(*httparty_options)

        if result.ok?
          JSON.parse(result.body)
        else
          raise Tatoru::Client::NodeError.new("HTTP error #{result.code} getting status. Request: #{httparty_options} | Response: #{result.body}")
        end
      end

      def ready?
        status["authorized"] == true
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

        result = HTTParty.send(*httparty_options)

        if result.created?
          JSON.parse(result.body)
        else
          raise Tatoru::Client::NodeError.new("HTTP error #{result.code} scanning #{url}: #{result.body}")
        end
      end

      def scan_file(file)
        httparty_options = [
          :post,
          "#{base_url}/scans",
          body: { scan: { asset: open(file), filename: file } },
          headers: { 
            "Authorization" => "Bearer #{api_token}",
          }
        ]

        result = HTTParty.send(*httparty_options)

        if result.created?
          JSON.parse(result.body)
        else
          raise Tatoru::Client::NodeError.new("HTTP error #{result.code} scanning #{file}: #{result.body}")
        end
      end

      private

      def api_token
        @configuration.api_token
      end

      def base_url
        @configuration.base_url
      end
    end
  end
end
