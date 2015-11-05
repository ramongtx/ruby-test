require 'rails_helper'

describe WelcomeController do

  # INDEX ======================================================================
  describe 'GET index' do
    it 'renders index if not logged in' do
      session[:loginToken] = nil
      get :index
      expect(response).to render_template(:index)
    end

    it 'redirects to /profile if logged in' do
      session[:loginToken] = "123123123"
      get :index
      expect(response).to redirect_to('/profile')
    end
  end

  # INDEX ======================================================================
  describe 'POST login' do
    it 'answers ok if email and pass are correct' do
      post :login, email: 'x@user.com', password: 'xxxxxxxx'
      expect(response.body).to eq('ok')
    end

    it 'answers ok if email and pass are correct' do
      post :login, email: 'x@user.com', password: ''
      expect(response.body).not_to eq('ok')
    end

    it 'answers ok if there is a login token' do
      post :login, token: '123123123'
      expect(response.body).to eq('ok')
    end
  end

end
