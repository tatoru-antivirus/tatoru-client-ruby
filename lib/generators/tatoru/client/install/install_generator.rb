module Tatoru
  module Client
    class InstallGenerator < Rails::Generators::Base
      desc 'Installs Tatoru::Client'

      source_root ::File.expand_path('../templates', __FILE__)

      def generate_initializer
        template 'initializer.rb', 'config/initializers/tatoru_client.rb'
      end
    end
  end
end
