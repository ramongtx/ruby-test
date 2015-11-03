class ProfileController < ApplicationController
  def index
    if session[:userToken]
      loginData = session[:userToken]
      apiSecret = '42e7faba26a5d2301e998a99d92a869172d3cb3ac3fb54aba432eec9b0ee064a'
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
