require 'active_support/core_ext/object/blank'
require 'i18n'
require 'desponders/error_responder'

I18n.load_path += [File.expand_path('lib/locales/errors.en.yml')]

describe Desponders::ErrorResponder do
  class MockErrorResponder < Struct.new(:to_format)
    include Desponders::ErrorResponder

    attr_accessor :controller, :resource

    def initialize(controller, resource)
      @controller = controller
      @resource   = resource
    end
  end

  let(:controller) { double(:controller, action_name: 'create') }
  let(:resource)   { double(:resource, errors: []) }

  subject(:responder) { MockErrorResponder.new(controller, resource) }

  before do
    resource.class.stub_chain(:model_name, :human).and_return('Mock')
  end

  it 'renders error messages when a non-get request has errors ' do
    responder.stub(has_errors?: true)

    expect(controller).to receive(:render).with(json: {
      message: 'Mock could not be created',
      errors:  []
    }, status: :unprocessable_entity)

    responder.to_format
  end

  it 'does not render without errors' do
    responder.stub(has_errors?: false)

    expect(controller).to_not receive(:render)

    responder.to_format
  end
end
