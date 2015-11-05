require 'rails_helper'

describe SignupController do
  context 'GET index' do
    let(:request) { get :index }

    before { request }
    subject { response }

    it { is_expected.to render_template(:index) }
    it { is_expected.to have_http_status(200) }
  end

  context 'POST signup' do
    context 'when good params' do
      before do
        @u = build(:random_user)
        post :signup, username: @u.username, email_address: @u.email, password: @u.password
      end
      after do
        User.unscoped.delete_all
      end
      subject { response.body }

      it { is_expected.to eq('ok') }
    end

    context 'when user exists locally' do
      before do
        @u = create(:random_user)
        post :signup, username: @u.username, email_address: @u.email, password: @u.password
      end
      after do
        User.unscoped.delete_all
      end
      subject { response.body }

      it { is_expected.to eq('Falhou em salvar o usuário') }
    end

    context 'when user exists remotely' do
      before do
        @u = create(:valid_user)
        post :signup, username: @u.username, email_address: @u.email, password: @u.password
      end
      after do
        User.unscoped.delete_all
      end
      subject { response.body }

      it { is_expected.to include('has already been taken') }
    end
  end
end
