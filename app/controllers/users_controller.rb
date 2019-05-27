class UsersController < ApplicationController

  get '/users/signup' do
    erb :"users/create_user"
  end
  
  get '/users/login' do
    erb :"users/login"
  end
  
  post '/users/signup' do
    @user = User.create(params[:user])
    redirect "/users/#{@user.id}"
  end
  
  get "/users/:id" do
    @user = User.find(params[:id])
    erb :"users/show"
  end
  
end