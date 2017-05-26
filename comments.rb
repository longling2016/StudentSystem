
require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Comment
  include DataMapper::Resource
  property :commentID, Serial
  property :name, String
  property :created_at, DateTime
  property :content, Text
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

# get '/songs/:id' do
#   @song = Song.get(params[:id])
#   erb :show_song
# end
#
# get '/songs/:id/edit' do
#   @song = Song.get(params[:id])
#   erb :edit_song
# end
#
# post '/songs' do
#   song = Song.create(params[:song])
#   redirect to("/songs/#{song.id}")
# end
#
# put '/songs/:id' do
#   song = Song.get(params[:id])
#   song.update(params[:song])
#   redirect to("/songs/#{song.id}")
# end
#
# delete '/songs/:id' do
#   Song.get(params[:id]).destroy
#   redirect to('/songs')
# end
