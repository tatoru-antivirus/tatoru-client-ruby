$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "tatoru/client/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "tatoru_client"
  spec.version     = Tatoru::Client::VERSION
  spec.authors     = ["Roberto Vasquez Angel"]
  spec.email       = ["roberto@vasquez-angel.de"]
  spec.homepage    = "https://www.tatoru.io"
  spec.summary     = "Tatoru Anti Virus Client."
  spec.license     = "Open source"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "zeitwerk"
  spec.add_dependency "httparty"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "guard-rspec"
end
