
require 'dm-core'
require 'dm-migrations'
require 'dm-timestamps'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Comment
  include DataMapper::Resource
  property :id, Serial
  property :content, Text
  property :name, String
  property :created_at, DateTime

  def created_at=datetime
    super DateTime.strptime(datetime, "%A, %d. %B %Y %I:%M%p")
  end
end

DataMapper.finalize

get '/comments' do
  @comments = Comment.all
  erb :comments
end

get '/comments/new' do
  @comment = Comment.new
  erb :new_comment
end

get '/comments/:id' do
  @comment = Comment.get(params[:id])
  erb :show_comment
end

post '/comments' do
  if params[:comment][:name].gsub!(/\W+/, '').eql?('') || params[:comment][:content].gsub!(/\W+/, '').eql?('')
    @type = 'comment'
    erb :wrong_date
  else
    comment = Comment.create(params[:comment])
    redirect to("/comments/#{comment.id}")
  end
end
