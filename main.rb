require 'sinatra'
require 'sass'
require './students'
require './comments'

get('/styles.css'){ scss :styles }

get '/' do
  erb :home
end

get '/about' do
  @title = "All About This Website"
  erb :about
end

get '/contact' do
  erb :contact
end

get '/video' do
  erb :video
end

get '/login' do
  erb :login
end

get '/logout' do
  erb :login
end

not_found do
  erb :not_found
end
