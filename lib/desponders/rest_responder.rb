module Desponders
  module RESTResponder
    def to_format
      case
      when get?
        display(resource, status: :ok)
      when has_errors?
        super
      when post?
        display(resource, status: :created)
      when put?
        display(resource, status: :ok)
      when delete?
        display({}, status: :no_content)
      end
    end
  end
end
