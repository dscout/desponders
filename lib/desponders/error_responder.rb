module Desponders
  module ErrorResponder
    # If it isn't a get request and the response model has errors it
    # automatically renders json with errors
    def to_format
      if has_errors?
        controller.render json: {
          message: lookup_message, errors: resource.errors
        }, status: :unprocessable_entity
      else
        super
      end
    end

    def lookup_message
      action  = controller.action_name
      lookup  = ['errors', action].join('.').to_sym
      options = { resource_name: resource.class.model_name.human }

      I18n.t(lookup, options)
    end
  end
end
