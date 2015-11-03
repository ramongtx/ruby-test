class ProfileController < ApplicationController
  def index
    @loginData = session[:userToken]
  end
end
