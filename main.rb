require 'sinatra'
require 'sass'
require './students'
require './comments'
require './login'

configure do
  enable :session
  set :username, "Superman"
  set :password, "SaveTheWorld"
end

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

get '/logout' do
  session.clear
  redirect to '/login'
end


not_found do
  erb :not_found
end
