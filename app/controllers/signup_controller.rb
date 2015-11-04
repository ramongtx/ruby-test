class SignupController < ApplicationController
  def signup
    userData = {
      username: params[:username],
      password: params[:password],
      email_address: params[:email_address] }

    urlstring = 'https://api-staging.socialidnow.com/v1/marketing/login/users'
    body = { 'user' => userData }.to_json
    headers = { 'Content-Type' => 'application/json', 'Accept' => '*/*' }
    auth = { username: '301', password: ENV['API_SECRET'] }

    signupResponse = HTTParty.post(urlstring,
                                   body: body,
                                   headers: headers,
                                   basic_auth: auth)

    if signupResponse.code == 201
      user_id = signupResponse.headers['location'].split('/').last
      user = User.create(username: params[:username],
                         password: params[:password],
                         email: params[:email_address],
                         social_id: user_id)
      if user.save
        render plain: 'ok'
      else
        render plain: 'Falhou em salvar o usuário'
      end
    else
      if signupResponse['error_description']
        render plain: signupResponse['error_description']
      else
        render plain: signupResponse
      end
    end
  end

  def index
  end
end
