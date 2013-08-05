require 'active_support/core_ext/module/delegation'

module Desponders
  module PaginatedResponder
    def to_format
      if get? && resource.respond_to?(:paginate)
        self.resource_size = resource.size
        self.resource      = resource.paginate(page: page, per_page: per_page)

        response.headers['Link'] = link_headers
      end

      super
    end

    private

    attr_accessor :resource, :resource_size

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

    def first_page
      1
    end

    def prev_page
      [first_page, page - 1].max
    end

    def next_page
      [last_page, page + 1].min
    end

    def last_page
      calculated = (resource_size.to_f / per_page).ceil

      calculated.zero? ? 1 : calculated
    end

    def link_headers
      base, rest = request.url.split('?')

      [construct_link_rel(base, first_page, per_page, 'first'),
       construct_link_rel(base, prev_page,  per_page, 'prev'),
       construct_link_rel(base, next_page,  per_page, 'next'),
       construct_link_rel(base, last_page,  per_page, 'last')].join(',')
    end

    def construct_link_rel(base, page, per_page, rel)
      %(#{base}?page=#{page}&per_page=#{per_page}; rel="#{rel}")
    end
  end
end
