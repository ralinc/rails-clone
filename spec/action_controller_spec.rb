require 'spec_helper'

class TestController < ActionController::Base
  before_action :callback, only: [:show]

  def index
    response << 'index'
  end

  def show
    response << 'show'
  end

  private

  def callback
    response << 'callback'
  end
end

class Request
  def params
    { 'id' => 1 }
  end
end

describe ActionController::Base do
  let(:controller) do
    controller = TestController.new
    controller.response = []
    controller
  end

  it 'processes an action' do
    controller.process :index

    expect(controller.response).to include('index')
  end

  it 'process an action on a real controller' do
    controller = PostsController.new
    controller.request = Request.new

    controller.process :show
  end

  it 'executes a callback' do
    controller.process :show

    expect(controller.response).to eq %w(callback show)
  end
end
