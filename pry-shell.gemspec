# frozen_string_literal: true

require_relative "lib/pry/shell/version"

Gem::Specification.new do |spec|
  spec.name          = "pry-shell"
  spec.version       = Pry::Shell::VERSION
  spec.authors       = ["Mehmet Emin INAC"]
  spec.email         = ["mehmetemininac@gmail.com"]

  spec.summary       = "Provides remote pry sessions."
  spec.description   = "pry-shell gem provides multiple remote pry sessions."
  spec.homepage      = "https://github.com/meinac/pry-shell"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/meinac/pry-shell"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "pry", ">= 0.13.0"
  spec.add_dependency "tty-markdown"
  spec.add_dependency "tty-prompt"
end
