class PlacesController < ApplicationController

  get '/places' do
    @places = Place.all
    erb :"places/index"
  end
  
  get '/places/new' do
    erb :"places/new"
  end
  
  post '/places' do
    @business = Place.new(params[:business])
    binding.pry
    redirect "/places/#{@business.id}"
  end
  
  get '/places/:id' do
    @business = Place.find(params[:id])
    erb :"places/show"
  end
  
  post '/places/:id/delete' do
    @business = Place.find(params[:id])
    @business.destroy
    redirect "/places"
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