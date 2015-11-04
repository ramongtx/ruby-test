class WelcomeController < ApplicationController
  def login
    if params[:token]
      session[:userToken] = params[:token]
      render plain: "ok"
    elsif
      userData = {
        password: params[:password],
        email_address: params[:email]
      }

      urlstring = 'https://api-staging.socialidnow.com/v1/marketing/login/users/login'

      signin = HTTParty.post(urlstring,
                                     body: userData.to_json,
                                     headers: { 'Content-Type' => 'application/json',
                                                'Accept' => '*/*'
                                              },
                                     basic_auth: { username: '301', password: ENV['API_SECRET'] }
                                    )
      if signin["error"]
        render plain: signin["error_description"]
      else
        session[:userToken] = signin["login_token"]
        render plain: 'ok'
      end
    end
  end

  def index
    if session[:userToken]
      redirect_to('/profile')
    elsif session[:userId]
      redirect_to('/profile')
    end
  end
end
