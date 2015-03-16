[![Stories in Ready](https://badge.waffle.io/zuppler/zuppler.png?label=ready&title=Ready)](https://waffle.io/zuppler/zuppler)
[![Build Status](https://travis-ci.org/zuppler/zuppler.png?branch=master)](https://travis-ci.org/zuppler/zuppler) 
[![Coverage Status](https://coveralls.io/repos/zuppler/zuppler/badge.png)](https://coveralls.io/r/zuppler/zuppler) 
[![Code Climate](https://codeclimate.com/github/zuppler/zuppler.png)](https://codeclimate.com/github/zuppler/zuppler) 
[![Dependency Status](https://gemnasium.com/zuppler/zuppler.png)](https://gemnasium.com/zuppler/zuppler)
[![PullReview stats](https://www.pullreview.com/github/zuppler/zuppler/badges/master.svg?)](https://www.pullreview.com/github/zuppler/zuppler/reviews/master)

# Zuppler 

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
@restaurant = Zuppler::Restaurant.new name: 'Oscar Pizza', address: '21 Wall St, New York'
@restaurant.save
@restaurant = Zuppler::Restaurant.find 'oscarpizza'
@restaurant.publish
```

``` ruby
@menu = Zuppler::Menu.new restaurant: @restaurant, name: 'pizzas special'
@menu.save
```

``` ruby
@category = Zuppler::Category.new menu: @menu, name: 'pizzas'
@category.save
```

``` ruby
@item = Zuppler::Item.new category: @category, name: 'margerita', price: 9.99
@item.save
```

``` ruby
@choice = Zuppler::Choice.new category: @category, name: 'toppings', multiple: true, min_qty: 2, max_qty: 5, priority: 1
@choice.save
```

``` ruby
@modifier = Zuppler::Modifier.new choice: @choice, name: 'cheese', price: 0.99
@modifier.save
```

Order actions:
``` ruby
@order = Zuppler::Order.find 'abcd-1234-efgh-5678'
@order.confirm duration: 30, sender: 'tablet app'
@order.cancel reason: 'too busy'
@order.miss reason: 'restaurant does not respond'
```

Order info:
``` ruby
@order = Zuppler::Order.find 'abcd-1234-efgh-5678'
@order.details.customer.name
@order.details.carts.first.items.first.name
@order.details.totals.tax
```

Order notifications:
``` ruby
notification = @order.notification :email
notification.execute sender: 'control panel'
notification.confirm sender: 'control panel'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
