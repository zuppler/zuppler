# Zuppler [![Build Status](https://travis-ci.org/zuppler/zuppler.png?branch=master)](https://travis-ci.org/zuppler/zuppler) [![Coverage Status](https://coveralls.io/repos/zuppler/zuppler/badge.png)](https://coveralls.io/r/zuppler/zuppler) [![Code Climate](https://codeclimate.com/github/zuppler/zuppler.png)](https://codeclimate.com/github/zuppler/zuppler) [![Dependency Status](https://gemnasium.com/zuppler/zuppler.png)](https://gemnasium.com/zuppler/zuppler)

Ruby wrapper for Zuppler API.

## Installation

Add this line to your application's Gemfile:

    gem 'zuppler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zuppler

## Usage


``` ruby
Zuppler.init 'channel', 'key'
```

``` ruby
options = {
  :name => 'Oscar Pizza', :remote_id => '123456',
  :logo => 'http://example.com/logo.png', :location => '123 North St New York',
  :owner => {:name => 'John', :email => 'doe@example.com', :phone => '123-456-789'}
}
restaurant = Zuppler::Restaurant.create options
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
