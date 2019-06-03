class UsersController < ApplicationController

  get "/users/:id" do
    @user = User.find(params[:id])
    erb :"users/show"
  end
  
  get "/users/:id/change_password" do
    @user = User.find(params[:id])
    erb :"users/change_password"
  end
  
  get "/users/:id/edit" do
    
  end
  
  patch "/users/:id" do
    binding.pry
    if params.keys.include?("new_password")
      
      if @user.id = current_user.id && @user.authenticate(params[:current_password]) && params[:new_password]==params[:confirm_password]
        @user.password = params[:new_password]
      else
        redirect "/users/#{@user.id}/change_password"
      end
    end
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