class UsersController < ApplicationController

    get '/users/signup' do
      erb :"users/create_user"
    end
  
    post '/users' do
      @user = User.create(params[:user])
      if @user.username != "" && @user.save
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
      else
        redirect "/users/signup"
      end
    end
    
    get '/users/login' do
      erb :"users/login"
    end
    
    get "/users/:id" do
      @user = User.find(params[:id])
      erb :"users/show"
    end
    
  end