# Guard::Bundler

[![Gem Version](https://badge.fury.io/rb/guard-bundler.png)](http://badge.fury.io/rb/guard-bundler) [![Build Status](https://travis-ci.org/guard/guard-bundler.png?branch=master)](https://travis-ci.org/guard/guard-bundler) [![Dependency Status](https://gemnasium.com/guard/guard-bundler.png)](https://gemnasium.com/guard/guard-bundler) [![Code Climate](https://codeclimate.com/github/guard/guard-bundler.png)](https://codeclimate.com/github/guard/guard-bundler) [![Coverage Status](https://coveralls.io/repos/guard/guard-bundler/badge.png?branch=master)](https://coveralls.io/r/guard/guard-bundler)

Bundler guard allows to automatically & intelligently install/update bundle when needed.

* Compatible with Bundler 1.0.x
* Tested against Ruby 1.9.3, 2.0.0, Rubinius & JRuby (1.9 mode only).

## Install

Please be sure to have [Guard](https://github.com/guard/guard) installed before continue.

Install the gem:

```bash
$ gem install guard-bundler
```

Add it to your `Gemfile`:

```ruby
group :development do
  gem 'guard-bundler'
end
```

Add guard definition to your Guardfile by running this command:

```bash
$ guard init bundler
```

## Usage

Please read [Guard usage doc](https://github.com/guard/guard#readme)

## Guardfile

Bundler guard can be really adapted to all kind of projects.

### Standard RubyGem project

```ruby
guard :bundler do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end
```

Please read [Guard doc](https://github.com/guard/guard#readme) for more information about the Guardfile DSL.

## Development

* Source hosted at [GitHub](https://github.com/guard/guard-bundler)
* Report issues/Questions/Feature requests on [GitHub Issues](https://github.com/guard/guard-bundler/issues)

Pull requests are very welcome! Make sure your patches are well tested. Please create a topic branch for every separate change
you make.

## Author

[Yann Lugrin](https://github.com/yannlugrin)

## Contributors

[https://github.com/guard/guard-bundler/graphs/contributors](https://github.com/guard/guard-bundler/graphs/contributors)
