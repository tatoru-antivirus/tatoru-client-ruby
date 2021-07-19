module Tatoru
  module Client
    class Url
      def self.scan(url)
        new(url).scan
      end

      def self.safe?(url)
        new(url).safe?
      end

      def self.infected?(url)
        new(url).infected?
      end

      def initialize(url)
        @node = Tatoru::Client::Node.new
        @url = url
      end

      def safe?
        scan['status'] == "clean"
      end

      def infected?
        !safe?
      end

      def scan
        @node.scan_url(@url)
      end
    end
  end
end