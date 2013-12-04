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
Zuppler.config do |config|
  config.channel_key = 'ccc',
  config.api_key = 'aaa',
  config.test = true
end
```

``` ruby
options = {
  :name => 'Oscar Pizza', :remote_id => '123456',
  :logo => 'http://example.com/logo.png', :location => '123 North St New York',
  :owner => {:name => 'John', :email => 'doe@example.com', :phone => '123-456-789'}
}
@restaurant = Zuppler::Restaurant.new options
@restaurant.save
```

``` ruby
@menu = Zuppler::Menu.new :restaurant => @restaurant, :name => 'pizzas special'
@menu.save
```

``` ruby
@category = Zuppler::Category.new :menu => @menu, :name => 'pizzas'
@category.save
```

``` ruby
@item = Zuppler::Item.new :category => @category, :name => 'margerita', :price => 9.99
@item.save
```

``` ruby
@choice = Zuppler::Choice.new :category => @category, :name => 'toppings', :multiple => true, :min_qty => 2, :max_qty => 5
@choice.save
```

``` ruby
@modifier = Zuppler::Modifier.new :choice => @choice, :name => 'cheese', :price => 0.99
@modifier.save
```

``` ruby
@order = Zuppler::Order.find :uuid => 'abcd-1234-efgh-5678'
@order.confirm
@order.reject
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
