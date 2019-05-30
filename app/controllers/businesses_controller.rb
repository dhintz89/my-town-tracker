class BusinessesController < ApplicationController

  get '/businesses' do
    @businesses = Business.all
    erb :"businesses/index"
  end
  
  get '/businesses/new' do
    erb :"businesses/new"
  end
  
  post '/businesses' do
    @business = Business.new(params[:business])
    binding.pry
    redirect "/businesses/#{@business.id}"
  end
  
  get '/businesses/:id' do
    @business = Business.find(params[:id])
    erb :"businesses/show"
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