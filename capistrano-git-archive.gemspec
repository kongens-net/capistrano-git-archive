# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/git_archive/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-git-archive'
  spec.version       = Capistrano::GitArchive::VERSION
  spec.authors       = ['Mikkel Riber']
  spec.email         = ['riber@kongens.net']
  spec.description   = 'git archive deploy strategy for Capistrano.'
  spec.summary       = 'git archive deploy strategy'
  spec.homepage      = 'https://github.com/kongens-net/capistrano-git-archive'
  spec.license       = 'MIT'

  spec.files         = ''
  spec.executables   = ''
  spec.test_files    = ''
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '>= 3.7.0', '< 4.0.0'
end
