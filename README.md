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
restaurant = Zuppler::Restaurant.create do |r|
  r.name, r.remote_id, r.logo, r.location = name, rid, logo, location
  r.owner = {:name => oname, :email => oemail, :phone => ophone}
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
