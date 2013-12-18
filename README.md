[![Build Status](https://travis-ci.org/dscout/desponders.png?branch=master)](https://travis-ci.org/dscout/desponders)
[![Code Climate](https://codeclimate.com/github/dscout/desponders.png)](https://codeclimate.com/github/dscout/desponders)

# Desponders

A stack of light-weight responders tailored to JSON APIs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'desponders', '~> 0.2.0'
```

## Usage

Create a `ActionController::Responder` subclass and include the responders that
you would like to use:

```ruby
class CustomResponder < ActionController::Responder
  include Desponders::ErrorResponder
  include Desponders::RESTResponder
  include Desponders::PaginatedResponder
  include Desponders::HTTPCacheResponder
end
```

Include the responder in any controllers serving API requests:

```ruby
class ApplicationController < ActionController::Base
  self.responder = CustomResponder
end
```

## PaginatedResponder

The `PaginatedResponder` automatically applies pagination to every multi
resource GET request. In order for pagination to work your resources must
respond to a `paginate` method that accepts `page` and `per_page` options.

## Thanks

The implementation of Desponders is based on the fanstastic work of Jose Valim
and his contributions to Responders within Rails, as well as Plataformatec's
Responders gem.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
