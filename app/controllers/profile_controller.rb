class ProfileController < ApplicationController
  def index
    if session[:userToken]
      loginData = session[:userToken]
      apiSecret = ENV['API_SECRET']
      urlstring = 'https://api-staging.socialidnow.com/v1/marketing/login/info'\
      '?api_secret=' + apiSecret + '&token=' + session[:userToken]


      apiresponse = HTTParty.get(urlstring, headers: {'Accept' => '*/*'})
      @name = apiresponse["name"]
      @picture = apiresponse["picture_url"]
      @jsonresponse = apiresponse

      p urlstring
      p apiresponse.code


      if apiresponse["error"]
        session[:userToken] = nil
        redirect_to('/')
      end
    elsif session[:userId]
      user = User.find(session[:userId])
      if user.valid?
        @name = user.username
        @jsonresponse = user.as_json
        @picture = ""
      else
        session[:userId] = nil
        redirect_to('/')
      end
    else
      redirect_to('/')
    end
  end

  def logout
    session[:userToken] = nil
    session[:userId] = nil
    redirect_to('/')
  end
end
