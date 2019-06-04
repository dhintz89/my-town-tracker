class PlacesController < ApplicationController

  get '/places' do
    erb :"places/index"
  end
  
  get '/places/new' do
    @recommendations = Recommendation.all
    @categories = Category.all
    binding.pry
    erb :"places/new"
  end
  
  post '/places' do
    @place = Place.create(params[:place])
    @place.user_id = current_user.id
    if !params[:category][:name].empty?
      @place.category = Category.find_or_create_by(name: params[:category][:name])
      @place.save
    end
    if !params[:recommendation][:name].empty?
      @place.recommendations << Recommendation.find_or_create_by(name: params[:recommendation][:name])
    end
    redirect "/places/#{@place.id}"
  end
  
  get '/places/filter' do
    @recommendations = Recommendation.all
    @categories = Category.all
    erb :"places/filters"
  end
  
  post '/places/filter' do 
    if !params[:visited].empty?
      @visit_results = user_places.select {|pl| pl.visited==params[:visited].to_i}
    end

    # @category_results = [match chosen category(s)]
    # @recommendation_results = [match chosen recommendation(s)]
    @filter_results = (@visit_results).uniq
    erb :"places/show_filtered"
  end
  
  get '/places/:id' do
    @place = Place.find(params[:id])
    erb :"places/show"
  end
  
  get '/places/:id/edit' do
    @place = Place.find(params[:id])
    @recommendations = Recommendation.all
    @categories = Category.all
    erb :"places/edit"
  end
  
  patch '/places/:id' do
    @place = Place.find(params[:id])
    @place.update(params[:place])
    if !params[:category][:name].empty?
      @place.category = Category.find_or_create_by(name: params[:category][:name])
      @place.save
    end
    if !params[:recommendation][:name].empty?
      @place.recommendations << Recommendation.find_or_create_by(name: params[:recommendation][:name])
    end
    flash[:message] = "#{@place.name} updated successfully"
    redirect "/places/#{@place.id}"    
  end
  
  post '/places/:id/delete' do
    @place = Place.find(params[:id])
    @place.destroy
    flash[:message] = "#{@place.name} has been deleted."
    redirect "/places"
  end
  
  helpers do
    def logged_in?
      !!session[:user_id]
    end
    
    def current_user
      User.find(session[:user_id])
    end
    
    def user_places
      current_user.places.all
    end
  end
  
end