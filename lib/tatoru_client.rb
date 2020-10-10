require "singleton"
require "httparty"

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.ignore "*~"
loader.do_not_eager_load("#{__dir__}/tatoru/client/engine")
loader.log!
loader.setup

module Tatoru
  module Client
    def self.configure
      yield Configuration
    end

    def self.root
      Pathname.new(::File.dirname(__dir__))
    end

    # def self.safe?(url)
    #   Scanner.safe?(url)
    # end

    # def self.virus?(url)
    #   Scanner.virus?(url)
    # end
  end
end

