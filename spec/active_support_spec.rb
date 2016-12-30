require 'spec_helper'
require 'active_record'
require 'active_support'

describe ActiveSupport::Dependencies do
  before do
    ActiveSupport::Dependencies.autoload_paths = Dir["#{__dir__}/test_app/app/*"]
  end

  it 'finds existing file' do
    file = ActiveSupport::Dependencies.search_for_file 'application_controller'
    expect(file).to eq "#{__dir__}/test_app/app/controllers/application_controller.rb"
  end

  it 'does not find missing file' do
    file = ActiveSupport::Dependencies.search_for_file 'unknown'
    expect(file).to eq nil
  end

  it 'loads missing constant' do
    Post
  end
end
