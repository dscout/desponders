module Desponders
  module HTTPCacheResponder
    # Stop the rendering chain if we have a fresh resource.
    def to_format
      return if do_http_cache? && do_http_cache!

      super
    end

    private

    def do_http_cache?
      get? && ActionController::Base.perform_caching &&
      resource.respond_to?(:updated_at)
    end

    def do_http_cache!
      controller.fresh_when(etag: resource,
                            last_modified: resource.updated_at,
                            public: false)
    end
  end
end
