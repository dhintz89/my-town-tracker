class PlacesController < ApplicationController

  get '/places' do
    erb :"places/index"
  end
  
  get '/places/new' do
    @recommendations = current_user.recommendations.all.uniq
    @categories = current_user.categories.all.uniq
    erb :"places/new"
  end
  
  post '/places' do
    @place = current_user.places.create(params[:place])
    if !params[:category][:name].empty?
      @place.category = Category.find_or_create_by(name: params[:category][:name])
    end
    if !params[:recommendation][:name].empty?
      @place.recommendations << Recommendation.find_or_create_by(name: params[:recommendation][:name])
    end
    @place.save
    redirect "/places/#{@place.id}"
  end
  
  get '/places/filter' do
    @recommendations = current_user.recommendations.all.uniq
    @categories = current_user.categories.all.uniq
    erb :"places/filters"
  end
  
  post '/places/filter' do 
    if params[:visited]
      @results = user_places.select {|pl| pl.visited==params[:visited].to_i}
    else
      @results = user_places
    end

    if params[:category_ids]
      @results.delete_if {|pl| params[:category_ids].index(pl.category.id.to_s)==nil}
    end
    
    if params[:recommendation_ids]
      @results.keep_if {|pl|
        params[:recommendation_ids].all? {|rec| pl.recommendations.ids.include?(rec.to_i)}
      }
    end

    @results
    erb :"places/show_filtered"
  end
  
  get '/places/:id' do
    @place = Place.find(params[:id])
    erb :"places/show"
  end
  
  get '/places/:id/edit' do
    @place = Place.find(params[:id])
    @recommendations = current_user.recommendations.all.uniq
    @categories = current_user.categories.all.uniq
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