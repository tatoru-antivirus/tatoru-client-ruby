module Tatoru
  module Client
    class Scan
      def self.status(uuid)
        new(uuid).status
      end

      def self.safe?(uuid)
        new(uuid).safe?
      end

      def self.infected?(uuid)
        new(uuid).infected?
      end

      def initialize(uuid)
        @node = Tatoru::Client::Node.new
        @uuid = uuid
      end

      def safe?
        scan['status'] == "clean"
      end

      def infected?
        !safe?
      end

      def scan
        @node.get_scan(@uuid)
      end
    end
  end
end
