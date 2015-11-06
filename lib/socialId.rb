module SocialId
  @@baseUrl = 'https://api-staging.socialidnow.com/v1/marketing/'

  def self.emailLogin(email, pass)
    urlstring = @@baseUrl + 'login/users/login'
    auth = { username: '301', password: ENV['API_SECRET'] }
    headers = { 'Content-Type' => 'application/json', 'Accept' => '*/*' }
    userData = { email_address: email, password: pass }

    HTTParty.post(urlstring, body: userData.to_json, headers: headers, basic_auth: auth)
  end

  def self.emailSignup(email, pass)
    urlstring = @@baseUrl + 'login/users'
    headers = { 'Content-Type' => 'application/json', 'Accept' => '*/*' }
    auth = { username: '301', password: ENV['API_SECRET'] }
    userData = { email_address: email, password: pass }
    body = { 'user' => userData }.to_json

    HTTParty.post(urlstring, body: body, headers: headers, basic_auth: auth)
  end
end
