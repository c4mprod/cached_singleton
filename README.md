# Cached::Singleton

CachedSingleton makes a single instance ActiveRecord object behave fully like a singleton.

## Installation

Add this line to your application's Gemfile:

    gem 'cached-singleton'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cached-singleton

## Usage

### Rails 3 apps

1. Create an initializer defining your cache strategy (by default we recommend):  
```ruby
CachedSingleton.default_cache_strategy = Rails.cache
```
2. Include the module CachedSingleton in the ActiveModels you want to become singletons
3. Done!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request