class ProfileController < ApplicationController
  def index
    if session[:userToken]
      loginData = session[:userToken]
      apiSecret = ENV['API_SECRET']
      urlstring = 'https://api-staging.socialidnow.com/v1/marketing/login/info'\
      '?api_secret=' + apiSecret + '&token=' + session[:userToken]

      @apiresponse = HTTParty.get(urlstring)
      @name = @apiresponse["name"]
      @picture = @apiresponse["picture_url"]
    else
      redirect_to('/')
    end
  end

  def logout
    session[:userToken] = nil
    redirect_to('/')
  end
end
