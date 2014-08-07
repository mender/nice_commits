# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nice_commits/version'

Gem::Specification.new do |spec|
  spec.name          = 'nice_commits'
  spec.version       = NiceCommits::VERSION
  spec.authors       = ['mender (Alexey Gorbov)']
  spec.email         = ['main.mender@gmail.com']
  spec.summary       = 'Git commit messages validator'
  spec.description   = 'Validates format of git commit messages'
  spec.homepage      = 'https://github.com/mender/nice_commits'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'git'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
end