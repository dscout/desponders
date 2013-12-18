require 'spec_helper'

describe Desponders::PaginatedResponder do
  class MockPaginatedResponderBase
    def to_format
    end
  end

  class MockPaginatedResponder < MockPaginatedResponderBase
    include Desponders::PaginatedResponder

    attr_accessor :controller, :resource

    def initialize(controller, resource)
      @controller = controller
      @resource   = resource
    end

    def get?; true; end
  end

  let(:controller) { double(:controller, request: request, response: response) }
  let(:paginated)  { double(:paginated) }
  let(:request)    { double(:request, params: {}, url: 'https://example.com/missions') }
  let(:response)   { double(:response, headers: {}) }
  let(:resource)   { double(:resource, paginate: paginated) }

  subject(:responder) { MockPaginatedResponder.new(controller, resource) }

  it 'replaces the current resource with a paginated scope' do
    responder.to_format
    responder.resource.should eq(paginated)
  end

  it 'defaults pagination to the first page' do
    resource.should_receive(:paginate).with(hash_including(page: 1))
    responder.to_format
  end

  it 'uses provided page and per_page params' do
    resource.should_receive(:paginate).with(page: 2, per_page: 25)

    request.params[:page]     = 2
    request.params[:per_page] = 25

    responder.to_format
  end
end
