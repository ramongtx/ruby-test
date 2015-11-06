class WelcomeController < ApplicationController
  def index
    redirect_to('/profile') if session[:loginToken]
  end
end
