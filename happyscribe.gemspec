lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "happyscribe/version"

Gem::Specification.new do |spec|
  spec.name          = "happyscribe"
  spec.version       = Happyscribe::VERSION
  spec.authors       = ["jean-christophe bauduin"]
  spec.email         = [""]

  spec.summary       = %q{ruby gem for the api of happyscribe}
  spec.description   = %q{the api of happyscribe is quite verbose, this ruby gem make it easy ! take a look at the documentation on github ( https://github.com/jbd0101/happyscribe-client ) }
  spec.homepage      = "https://github.com/jbd0101/happyscribe-client"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jbd0101/happyscribe-client"
  spec.metadata["changelog_uri"] = "https://github.com/jbd0101/happyscribe-client"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
