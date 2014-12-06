# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'guard/bundler/version'

Gem::Specification.new do |s|
  s.name        = 'guard-bundler'
  s.version     = Guard::BundlerVersion::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = 'MIT'
  s.authors     = ['Yann Lugrin']
  s.email       = ['yann.lugrin@sans-savoir.net']
  s.homepage    = 'https://rubygems.org/gems/guard-bundler'
  s.summary     = 'Guard gem for Bundler'
  s.description = 'Guard::Bundler automatically install/update your gem bundle when needed'

  s.required_ruby_version = '>= 1.9.2'

  s.add_dependency 'guard',   '~> 2.2'
  s.add_dependency 'bundler', '~> 1.0'

  s.files        = Dir.glob('{lib}/**/*') + %w[LICENSE README.md]
  s.require_path = 'lib'
end

