class WelcomeController < ApplicationController
  def login
    session[:userToken] = params[:token]
    render plain: "ok"
  end
end
