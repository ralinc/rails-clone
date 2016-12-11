require 'spec_helper'
require 'active_record/base'
require './spec/test_app/app/models/application_record'
require './spec/test_app/app/models/post'

describe ActiveRecord::Base do
  let(:attributes) { {id: 1, title: 'Code'} }

  before do
    Post.establish_connection database: "./spec/test_app/db/development.sqlite3"
  end

  it 'initializes with attributes' do
    post = Post.new attributes

    expect(post).to have_attributes(attributes)
  end

  it 'executes sql' do
    rows = Post.connection.execute 'SELECT * FROM posts'

    expect(rows.first.keys).to eq([:id, :title, :content, :created_at, :updated_at])
  end

  it 'lists all records' do
    posts = Post.all

    expect(posts.size).to eq 3
    expect(posts.first).to have_attributes(attributes)
  end

  it 'finds a record by id' do
    post = Post.find 1

    expect(post).to have_attributes(attributes)
  end
end
