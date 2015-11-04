class WelcomeController < ApplicationController
  def login
    session[:userToken] = params[:token]
    render plain: "ok"
  end

  def index
    if session[:userToken]
      redirect_to('/profile')
    elsif session[:userId]
      redirect_to('/profile')
    end
  end
end
