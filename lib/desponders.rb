require 'action_controller/base'

module Desponders
  autoload :ErrorResponder,     'desponders/error_responder'
  autoload :HttpCacheResponder, 'desponders/http_cache_responder'
  autoload :PaginatedResponder, 'desponders/paginated_responder'
  autoload :RestResponder,      'desponders/rest_responder'

  class Railtie < ::Rails::Railtie
    require 'active_support/i18n'
    I18n.load_path << File.expand_path('../desponders/locales/en.yml', __FILE__)
  end
end
