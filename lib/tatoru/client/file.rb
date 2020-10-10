module Tatoru
  module Client
    class File
      def self.scan(file)
        new(file).scan
      end

      def self.safe?(file)
        new(file).safe?
      end

      def self.infected?(file)
        new(file).infected?
      end

      def initialize(file)
        @node = Tatoru::Client::Node.new
        @file = file
      end

      def safe?
        scan['status'] == "clean"
      end

      def infected?
        !safe?
      end

      def scan
        @node.scan_file(@file)
      end
    end
  end
end