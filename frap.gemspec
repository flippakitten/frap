lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "frap/version"

Gem::Specification.new do |spec|
  spec.name          = "frap"
  spec.version       = Frap::VERSION
  spec.authors       = ["James Gascoigne - Taylor"]
  spec.email         = ["james@flippakitten.com"]

  spec.summary       = %q{Flutter and Rails App Generators}
  spec.description   = %q{CLI to create a Flutter App backed with a Rails server for quick app protoyping}
  spec.homepage      = "https://github.com/flippakitten/frap"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/flippakitten/frap"
    spec.metadata["changelog_uri"] = "https://github.com/flippakitten/frap/wiki/Change-Log-Published"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ['frap']
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.6.1'

  spec.add_development_dependency "bundler", "~> 2.0.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.7.0"
end
