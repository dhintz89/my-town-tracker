class UsersController < ApplicationController

  get "/users/:id" do
    if logged_in?
      @user = User.find(params[:id])
      if @user == current_user
        erb :"users/show"
      else
        erb :"users/failure"
      end
    else
      flash[:message] = "Not currently logged in. Please log in to continue."
      redirect '/login'
    end
  end
  
  get "/users/:id/change_password" do
    @user = User.find(params[:id])
    if @user == current_user
      erb :"users/change_password"
    else
      flash[:message] = "Not logged in as requested user."
      redirect "/users/#{current_user.id}"
    end
  end
  
  get "/users/:id/edit" do
    @user = User.find(params[:id])
    if @user == current_user
      erb :"users/edit"
    else
      flash[:message] = "Not logged in as requested user."
      redirect "/users/#{current_user.id}" 
    end
  end
  
  patch "/users/:id" do
    @user = User.find(params[:id])
    if params.keys.include?("new_password")
      
      if @user.authenticate(params[:current_password]) && params[:new_password]==params[:confirm_password]
        @user.update(password: params[:new_password])
        @user.save
        # password not actually changing
        flash[:message] = "Password successfully changed"
        redirect "/users/#{@user.id}"
      else
        flash[:message] = "Password could not be changed. Please try again."
        redirect "/users/#{@user.id}/change_password"
      end
    else
      if @user.authenticate(params[:current_password])
        @user.update(params[:user])
        flash[:message] = "Profile successfully updated."
        redirect "/users/#{@user.id}"
      else
        flash[:message] = "Changes could not be saved, please check that your password was entered correctly."
        redirect "/users/#{@user.id}/edit"
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