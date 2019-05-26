class UsersController < ApplicationController
  
  get '/users/signup' do
    erb :"users/create_user"
  end
  
  get '/users/login' do
    erb :"users/login"
  end
  
end