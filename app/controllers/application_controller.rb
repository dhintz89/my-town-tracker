require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret_password"
    use Rack::Flash
  end
  
  get '/' do 
    erb :index
  end
  
end