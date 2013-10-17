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
  s.homepage    = 'http://rubygems.org/gems/guard-bundler'
  s.summary     = 'Guard gem for Bundler'
  s.description = 'Guard::Bundler automatically install/update your gem bundle when needed'

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project         = 'guard-bundler'

  s.add_dependency 'guard',   '>= 1.1'
  s.add_dependency 'bundler', '>= 1.0'

  s.add_development_dependency 'rspec', '>= 2.14.1'

  s.files        = Dir.glob('{lib}/**/*') + %w[LICENSE README.md]
  s.require_path = 'lib'
end

