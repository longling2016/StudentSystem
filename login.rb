require './students'

get '/login' do
  puts 'inside login'
  puts session[:message]
  erb :login
end

get '/successlogin' do
  erb :successlogin
end

post '/login' do
  puts 'here'
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    puts 'inside if'
    puts session[:message]
    redirect to "#{session[:message]}"
  else
    puts 'inside else'
    erb :login
  end
end

