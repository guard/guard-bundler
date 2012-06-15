# Guard::Bundler

Bundler guard allows to automatically & intelligently install/update bundle when needed.

* Compatible with Bundler 1.0.x
* Tested against Ruby 1.8.7, 1.9.2, 1.9.3, REE and the latest versions of Rubinius.

## Install

Please be sure to have [Guard](https://github.com/guard/guard) installed before continue.

Install the gem:

```
$ gem install guard-bundler
```

Add it to your Gemfile (inside development group):

``` ruby
group :development do
  gem 'guard-bundler'
end
```

Add guard definition to your Guardfile by running this command:

```
$ guard init bundler
```

## Usage

Please read [Guard usage doc](https://github.com/guard/guard#readme)

## Guardfile

Bundler guard can be really adapted to all kind of projects.

### Standard RubyGem project

```ruby
guard 'bundler' do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end
```

Please read [Guard doc](https://github.com/guard/guard#readme) for more information about the Guardfile DSL.

== Development

* Source hosted at [GitHub](https://github.com/guard/guard-bundler)
* Report issues/Questions/Feature requests on [GitHub Issues](https://github.com/guard/guard-bundler/issues)

Pull requests are very welcome! Make sure your patches are well tested. Please create a topic branch for every separate change
you make.

== Authors

{Yann Lugrin}[https://github.com/yannlugrin]
