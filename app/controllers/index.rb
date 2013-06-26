get '/' do
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
    session[:auth] = @user.id
    redirect "/user/#{@user.id}"
  else
    redirect '/'
  end
end

get '/user/:id' do
  redirect '/' unless session[:auth]
  @user = User.find(session[:auth])
  @url = Url.new
  @new_url = params[:url]
  erb :feelsgoodpage
end

get '/logout' do
  session[:auth] = nil if session[:auth]
  redirect '/'
end

post '/urls' do
  @url = Url.create(:long_url => params[:long_url], :click_count => 0, :user_id => session[:auth])
  if @url.id?
    redirect "/user/#{session[:auth]}"
  else
    erb :index
  end
end

get '/:short' do
  @url = Url.find_by_short_url(params[:short])
  redirect @url.long_url
end
