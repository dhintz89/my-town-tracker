class PlacesController < ApplicationController

  get '/places' do
    redirect_if_not_logged_in
    @status = (user_places.select{|pl| pl.visited==1}.length.to_f/user_places.length.to_f)*100
    erb :"places/index"
  end
  
  get '/places/new' do
    if logged_in?
      @recommendations = current_user.recommendations.all.uniq
      @categories = current_user.categories.all.uniq
      erb :"places/new"
    else
      flash[:message] = "Must log in to continue."
      redirect "/"
    end
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
    if logged_in?
      @recommendations = current_user.recommendations.all.uniq
      @categories = current_user.categories.all.uniq
      erb :"places/filters"
    else
      flash[:message] = "Must log in to continue."
      redirect "/"
    end
  end
  
  post '/places/filter' do 
    # Use SQL for filters
    if params[:visited]
      @results = user_places.select {|pl| pl.visited==params[:visited].to_i}
    else
      @results = user_places.to_a
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
    if logged_in?
      @place = Place.find(params[:id])
      if user_places.include?(@place)
        erb :"places/show"
      else
        flash[:message] = "You do not have access to requested record."
        redirect "/users/#{current_user.id}"
      end
    else
      flash[:message] = "Must log in to continue."
      redirect "/"
    end
  end
  
  get '/places/:id/edit' do
    if logged_in?
      @place = Place.find(params[:id])
      if user_places.include?(@place)
        @recommendations = current_user.recommendations.all.uniq
        @categories = current_user.categories.all.uniq
        erb :"places/edit"
      else
        flash[:message] = "You do not have access to requested record."
        redirect "/users/#{current_user.id}"
      end
    else
      flash[:message] = "Must log in to continue."
      redirect "/"
    end
  end
  
  patch '/places/:id' do
    @place = Place.find(params[:id])
    if !logged_in? || !current_user.places.include?(@place) 
      flash[:message] = "You do not have access to requested record."      
      redirect "/users/#{current_user.id}"
    end
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
  
  delete '/places/:id/delete' do
    @place = Place.find(params[:id])
    if user_places.include?(@place)
      @place.destroy
      flash[:message] = "#{@place.name} has been deleted."
      redirect "/places"
    else
      flash[:message] = "You do not have access to requested record."
      redirect "/places"
    end
  end
  
  helpers do
    def user_places
      current_user.places.all
    end
    
    def redirect_if_not_logged_in
      if !logged_in?
        flash[:message] = "Must log in to continue."
        redirect "/"
      end
    end
      
  end
  
end