# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'guard/bundler/version'

Gem::Specification.new do |s|
  s.name        = 'guard-bundler'
  s.version     = Guard::BundlerVersion::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Yann Lugrin']
  s.email       = ['yann.lugrin@sans-savoir.net']
  s.homepage    = 'http://rubygems.org/gems/guard-bundler'
  s.summary     = 'Guard gem for Bundler'
  s.description = 'Guard::Bundler automatically install/update your gem bundle when needed'

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project         = 'guard-bundler'

  s.add_dependency 'guard',   '>= 0.2.2'
  s.add_dependency 'bundler', '>= 1.0.0'

  s.add_development_dependency 'rspec',       '~> 2.6.0'
  s.add_development_dependency 'guard-rspec', '~> 0.4.0'

  s.files        = Dir.glob('{lib}/**/*') + %w[LICENSE README.rdoc]
  s.require_path = 'lib'

  s.rdoc_options = ["--charset=UTF-8", "--main=README.rdoc", "--exclude='(lib|test|spec)|(Gem|Guard|Rake)file'"]
end