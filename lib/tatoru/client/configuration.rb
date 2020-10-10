module Tatoru
  module Client
    class Configuration
      include Singleton 

      def self.values
        instance.values
      end

      def self.values=(values)
        instance.values = values
      end
      
      def values
        (@values ||= {})
      end

      def values=(values)
        @values = values
      end

      def self.region
        instance.region
      end

      def self.region=(value)
        instance.region = value
      end
      
      def region
        values[:region] ||= "staging-eu-api"
      end

      def region=(value)
        @values[:region] = value
      end

      def self.api_token
        instance.api_token
      end

      def self.api_token=(value)
        instance.api_token = value
      end
      
      def api_token
        values[:api_token] ||= "189b4b6c94917d2eeb5ea69da334d04c"
      end

      def api_token=(value)
        @values[:api_token] = value
      end
    end
  end
end
