

get '/login' do
  erb :login
end

post '/login' do
  puts session[:message]
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    if session[:message].nil?
      erb :successlogin
    else
      redirect to("#{session[:message]}")
    end
  else
    erb :login
  end
end

