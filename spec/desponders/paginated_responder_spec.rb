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
  let(:resource)   { double(:resource, paginate: paginated, size: 100) }

  subject(:responder) { MockPaginatedResponder.new(controller, resource) }

  def link_header
    controller.response.headers['Link']
  end

  context 'with a paginatable resource on a get request' do
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

    it 'injects resource urls into a LINK header' do
      request.params[:page] = 2

      responder.to_format

      link_header.tap do |header|
        header.should include('https://example.com/missions?page=1&per_page=30; rel="first"')
        header.should include('https://example.com/missions?page=1&per_page=30; rel="prev"')
        header.should include('https://example.com/missions?page=3&per_page=30; rel="next"')
        header.should include('https://example.com/missions?page=4&per_page=30; rel="last"')
      end
    end

    it 'ignores params in the request url when constructing headers' do
      request.stub(url: 'https://example.com/missions?thing=1&other=2')

      responder.to_format

      link_header.should_not include('?thing=1&other=2')
    end

    it 'calculates the next page based on resource size and the per_page value' do
      resource.stub(size: 500)

      request.params[:page]     = 3
      request.params[:per_page] = 50

      responder.to_format

      link_header.tap do |header|
        header.should include('page=2&per_page=50; rel="prev"')
        header.should include('page=4&per_page=50; rel="next"')
      end
    end

    it 'prevents the next and last pages from being 0' do
      resource.stub(size: 0)

      responder.to_format

      link_header.should include('page=1&per_page=30; rel="next"')
      link_header.should include('page=1&per_page=30; rel="last"')
    end

    it 'calculates the last page based on resource size and the per_page value' do
      resource.stub(size: 500)

      request.params[:per_page] = 50

      responder.to_format

      link_header.should include('page=10&per_page=50; rel="last"')
    end
  end
end
