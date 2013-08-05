require 'spec_helper'

describe Desponders::RestResponder do
  class MockRestResponderBase
    def to_format
      '{}'
    end
  end

  class MockRestResponder < MockRestResponderBase
    include Desponders::RestResponder

    attr_accessor :resource

    def initialize(resource)
      @resource = resource
    end

    def display
    end

    def get?;        false; end
    def post?;       false; end
    def put?;        false; end
    def delete?;     false; end
    def has_errors?; false; end
  end

  let(:resource) { double(:resource) }

  subject(:responder) { MockRestResponder.new(resource) }

  it 'renders the resource with 200 status with a get request' do
    responder.stub(get?: true)

    expect(responder).to receive(:display).with(resource, status: :ok)

    responder.to_format
  end

  it 'renders the resource with 201 created with a create request' do
    responder.stub(post?: true)

    expect(responder).to receive(:display).with(resource, status: :created)

    responder.to_format
  end

  it 'renders the resource with a put request' do
    responder.stub(put?: true)

    expect(responder).to receive(:display).with(resource, status: :ok)

    responder.to_format
  end

  it 'renders no content with a delete request' do
    responder.stub(delete?: true)

    expect(responder).to receive(:display).with({}, status: :no_content)

    responder.to_format
  end

  it 'falls through to super with errors' do
    responder.stub(has_errors?: true)

    expect(responder.to_format).to eq('{}')
  end
end
