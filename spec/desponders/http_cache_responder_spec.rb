require 'spec_helper'

describe Desponders::HttpCacheResponder do
  class MockHttpCacheResponderBase
    def to_format
      '{}'
    end
  end

  class MockHttpCacheResponder < MockHttpCacheResponderBase
    include Desponders::HttpCacheResponder

    attr_accessor :controller

    def initialize(controller)
      @controller = controller
    end
  end

  let(:controller) { double(:controller, fresh_when: true) }
  let(:resource)   { double(:resource, updated_at: nil) }
  let(:collection) { double(:collection) }

  subject(:responder) { MockHttpCacheResponder.new(controller) }

  it 'returns nothing with a single resource on get' do
    responder.stub(get?: true, fresh_when: true, resource: resource)

    expect(responder.to_format).to be_nil
  end

  it 'passes through with multiple resources on get' do
    responder.stub(get?: true, resource: collection)

    expect(responder.to_format).to be_present
  end

  it 'passes through without a fresh resource' do
    controller.stub(fresh_when: false)
    responder.stub(get?: true, resource: resource)

    expect(responder.to_format).to be_present
  end

  it 'passes through without a get request' do
    responder.stub(get?: false, resource: resource)

    expect(responder.to_format).to be_present
  end

  it 'does not cache if perform_caching is false' do
    responder.stub(get?: true, resource: resource)

    ActionController::Base.stub(perform_caching: false)

    expect(responder.to_format).to be_present
  end
end
