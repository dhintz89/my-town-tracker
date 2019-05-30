class PlacesController < ApplicationController

  get '/places' do
    @places = Place.all
    erb :"places/index"
  end
  
  get '/places/new' do
    erb :"places/new"
  end
  
  post '/places' do
    @place = Place.new(name: params[:place][:name])
    @place.category = Category.find_or_create_by(name: params[:place][:category])
    # params[:place][:recommendation].each {|rec_id| @place.recommendations << Recommendation.find_by_id(rec_id)}
    binding.pry
    redirect "/places/#{@place.id}"
  end
  
  get '/places/:id' do
    @place = Place.find(params[:id])
    erb :"places/show"
  end
  
  post '/places/:id/delete' do
    @place = Place.find(params[:id])
    @place.destroy
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