require "singleton"
require "httparty"

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.ignore "*~"
unless defined?(Rails)
  loader.do_not_eager_load("#{__dir__}/tatoru/client/engine")
  loader.do_not_eager_load("#{__dir__}/generators")
end
loader.setup

module Tatoru
  module Client
    def self.configure
      yield Configuration
    end

    def self.root
      Pathname.new(::File.dirname(__dir__))
    end
  end
end

Tatoru::Client::Engine if defined?(Rails)
