require 'active_support/core_ext/module/delegation'

module Desponders
  module PaginatedResponder
    def to_format
      if get? && resource.respond_to?(:paginate)
        self.resource = resource.paginate(page: page, per_page: per_page)
      end

      super
    end

    private

    attr_accessor :resource

    delegate :response, :request, to: :controller

    def default_page
      1
    end

    def default_per_page
      30
    end

    def page
      (request.params[:page] || default_page).to_i
    end

    def per_page
      (request.params[:per_page] || default_per_page).to_i
    end
  end
end
