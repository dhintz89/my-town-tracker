class UsersController < ApplicationController

  get '/users/signup' do
    erb :"users/create_user"
  end

  post '/signup' do
    @user = User.create(params[:user])
    if @user.username != "" && @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect "/signup"
    end
  end
  
  get '/users/login' do
    erb :"users/login"
  end
  
  post '/login' do
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
  end
  
  get "/users/:id" do
    @user = User.find(params[:id])
    binding.pry
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