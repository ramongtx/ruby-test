class WelcomeController < ApplicationController
  def login
    if params[:token]
      session[:loginToken] = params[:token]
      render plain: 'ok'
    else
      userData = { password: params[:password],
                   email_address: params[:email] }

      urlstring = 'https://api-staging.socialidnow.com/v1/marketing/login/users/login'
      auth = { username: '301', password: ENV['API_SECRET'] }
      headers = { 'Content-Type' => 'application/json', 'Accept' => '*/*' }

      signin = HTTParty.post(urlstring,
                             body: userData.to_json,
                             headers: headers,
                             basic_auth: auth)

      if signin['error']
        render plain: signin['error_description']
      else
        session[:loginToken] = signin['login_token']
        session[:loginEmail] = params[:email]
        render plain: 'ok'
      end
    end
  end

  def index
    redirect_to('/profile') if session[:loginToken]
  end
end
