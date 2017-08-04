require 'rubygems'
require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/post.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :body, Text
  property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Post.auto_upgrade!

get '/' do
  erb :index
end

get '/create_post' do
    # 1. params로 날라온 데이터를 각각에 저장해주고,
  @title = params[:title]
  @body = params[:body]
  
  # 2. 각각의 내용을 해당하는 데이터베이스 column에 맞게 저장해주면 됩니다.
  Post.create(
    title: @title,
    body: @body
  )
  erb :create_post
end