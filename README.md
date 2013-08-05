# Desponders

A stack of light-weight responders tailored to JSON APIs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'desponders', '0.2.0'
```

## Usage

Use the provided `ApiResponder`, which includes all of the responder modules in
a sane order:

* Desponders::ErrorResponder
* Desponders::RESTResponder
* Desponders::PaginatedResponder
* Desponders::HTTPCacheResponder

Alternatively, create a `ActionController::Responder` subclass and include the
responders that you would like to use:

```ruby
class CustomResponder < ActionController::Responder
  include Desponders::RESTResponder
  include Desponders::HTTPCacheResponder
end
```

Include the responder in any controllers serving API requests:

```ruby
class ApplicationController < ActionController::Base
   # Included
  self.responder = Desponder::Responder

  # Custom
  self.responder = CustomResponder
end
```

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
