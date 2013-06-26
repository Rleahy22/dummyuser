get '/' do
  puts session[:auth]
  erb :index
end

get '/signup' do
  erb :signup
end

post '/create_user' do
  User.create(params[:user])
  redirect '/'
end

post '/login' do
  @user = User.check_login(params)
  unless @user.nil?
    session[:auth] = true
    redirect "/user/#{@user.id}"
  else
    redirect '/'
  end
end

get '/user/:id' do
  redirect '/' if session[:auth] != true
  erb :feelsgoodpage  
end

get '/logout' do
  session[:auth] = false if session[:auth] == true
  redirect '/'
end
