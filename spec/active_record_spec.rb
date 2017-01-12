require 'spec_helper'

describe ActiveRecord::Base do
  let(:attributes) { { id: 1, title: 'Code' } }

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

  describe '(where clause)' do
    it 'limits the records' do
      relation = Post.where('id = 2')

      expect(relation.size).to eq 1
      expect(relation.first.id).to eq 2
    end

    it 'is chainable' do
      relation = Post.where('id = 2').where('title IS NOT NULL')

      expect(relation.to_sql).to eq 'SELECT * FROM posts WHERE id = 2 AND title IS NOT NULL'
    end
  end
end
