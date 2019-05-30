class BusinessesController < ApplicationController
  
  get '/businesses' do
    @businesses = Business.all
    erb :"businesses/index"
  end
  
  get '/businesses/new' do
    
  end
  
  post '/businesses' do
    
  end
  
  post '/businesses/:id/delete' do
    @business = Business.find(params[:id])
    @business.destroy
    redirect "/businesses"
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