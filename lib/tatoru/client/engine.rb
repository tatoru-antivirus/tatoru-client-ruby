module Tatoru
  module Client
    class Engine < ::Rails::Engine
      isolate_namespace Tatoru::Client
    end
  end
end
