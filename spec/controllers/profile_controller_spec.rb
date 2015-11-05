require 'rails_helper'

describe ProfileController do
  context 'GET index' do
    context 'is not logged in' do
      before do
        session[:loginToken] = nil
        get :index
      end
      subject { response }
      it { is_expected.to redirect_to('/') }
    end

    context 'has bad login token' do
      before do
        session[:loginToken] = '123123123'
        get :index
      end
      subject { response }
      it { is_expected.to redirect_to('/') }
    end
  end
end
