require 'action_controller/base'

module Desponders
  autoload :ErrorResponder,     'desponders/error_responder'
  autoload :HttpCacheResponder, 'desponders/http_cache_responder'
  autoload :PaginatedResponder, 'desponders/paginated_responder'
  autoload :RestResponder,      'desponders/rest_responder'
end
