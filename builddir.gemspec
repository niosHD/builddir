# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'builddir/version'

Gem::Specification.new do |spec|
  spec.name          = Builddir::NAME
  spec.version       = Builddir::VERSION
  spec.authors       = ["Mario Werner"]
  spec.email         = ["mario.werner@iaik.tugraz.at"]
  spec.summary       = %q{builddir is a little helper tool for C/C++ programmers to manage out-of-source build directories.}
  spec.description   = %q{builddir manages mappings between build directories and the associated source directories.}
  spec.homepage      = "https://github.com/niosHD/builddir.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.bindir        = "bin"

  spec.post_install_message = "Thank you for installing builddir.\n\nPlease follow the remaining installation steps from the README (#{spec.homepage}) to finish the installation.\n\n"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "trollop", "~> 2.0"
end
