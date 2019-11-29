require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "soup"
  end

  get "/" do
    if is_logged_in?
      redirect '/recipes'
    else
      erb :index
    end
  end

  helpers do

    def current_user
      @user = User.find_by_id(session[:user_id])
    end

    def is_logged_in?
      !!current_user
    end

    def redirect_if_not_logged_in
      if !is_logged_in?
        flash[:message] = "Please log in to view that page."
        redirect "/"
      end
    end

    def redirect_if_not_creator(recipe)
      if current_user.id != recipe.user_id
        flash[:message] = "You are not able to edit a recipe you have not created."
        redirect "/storys/#{.id}"
      end

    end

  end

end
