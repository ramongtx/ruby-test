class ProfileController < ApplicationController
  def index
    if session[:loginToken]

      urlstring = 'https://api-staging.socialidnow.com/v1/marketing/login/info'\
      '?api_secret=' + ENV['API_SECRET'] + '&token=' + session[:loginToken]

      apiresponse = HTTParty.get(urlstring, headers: {'Accept' => '*/*'})

      if apiresponse["error"]
        session[:loginToken] = nil
        redirect_to('/')
      else
        setProfile(apiresponse)
      end
    else
      redirect_to('/')
    end
  end

  def setProfile(apiresponse)
    @name = apiresponse["name"]
    @picture = apiresponse["picture_url"]
    @jsonresponse = apiresponse
  end

  def logout
    session[:loginToken] = nil
    redirect_to('/')
  end
end
