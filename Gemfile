source 'http://rubygems.org'

gemspec

gem 'rake'

# optional development dependencies
require 'rbconfig'

if Config::CONFIG['target_os'] =~ /darwin/i
  gem 'growl', :require => false
end
if Config::CONFIG['target_os'] =~ /linux/i
  gem 'libnotify', '~> 0.7.1', :require => false
end
if RbConfig::CONFIG['target_os'] =~ /mswin|mingw/i
  gem 'win32console', :require => false
  gem 'rb-notifu', '>= 0.0.4', :require => false
end
