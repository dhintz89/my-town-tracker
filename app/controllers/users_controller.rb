class UsersController < ApplicationController

  get '/signup' do
    erb :"users/create_user"
  end

  post '/signup' do
    @user = User.new(params[:user])
    if @user.valid? && @user.save
      session[:user_id] = @user.id
      flash[:message] = "User successfully created"
      redirect "/users/#{@user.id}"
    else
      flash[:message] = "Problem creating new user. Please try again."
      redirect "/signup"
    end
  end
  
  get '/login' do
    erb :"users/login"
  end
  
  post '/login' do
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      flash[:message] = "Incorrect username or password. Please try again."
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    flash[:message] = "Successfully logged out"
    redirect '/'
  end
  
  get "/users/:id" do
    @user = User.find(params[:id])
    erb :"users/show"
  end
  
  helpers do
    def logged_in?
      !!session[:user_id]
    end
    
    def current_user
      User.find(session[:user_id])
    end
  end
    
end