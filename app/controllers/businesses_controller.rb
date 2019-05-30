class BusinessesController < ApplicationController
  
  get '/businesses' do
    @businesses = Business.all
    erb :"businesses/index"
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