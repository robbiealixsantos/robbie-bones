get '/sessions/login' do
  erb :'sessions/login'
end

post '/sessions' do
  @user = User.authenticate(params[:user])
  if @user
    session[:id] = @user.id
    redirect '/'
  else
    @error = "User email and/or password not valid!"
    erb :'sessions/login'
  end
end

delete '/sessions' do
  session[:id] = nil
  redirect '/'
end