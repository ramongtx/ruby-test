require 'rails_helper'

describe UsersController do

  # INDEX ======================================================================
  describe 'GET index' do
    context 'when there are users' do
      before(:all) do
        @users = create_list(:valid_user, 3)
        @userx = @users[rand @users.count]
      end

      after(:all) do
        User.unscoped.delete_all
      end

      context 'the response' do
        before do
          get :index
        end

        specify 'is correct' do
          expect(response).to have_http_status(:ok)
        end

        describe 'body' do
          let(:body) { response.body }
          let(:json) { JSON.parse(body) }

          it 'has correct number of results' do
            expect(json.count).to eq(3)
          end

          it 'has email and username info' do
            expect(body).to include(@userx.email)
            expect(body).to include(@userx.username)
          end
        end
      end
    end

    context 'when there are NO users' do
      context 'the response' do
        before do
          get :index
        end

        specify 'is correct' do
          expect(response).to have_http_status(:ok)
        end

        describe 'body' do
          let(:body) { response.body }
          let(:json) { JSON.parse(body) }

          it 'has correct number of results' do
            expect(json.count).to eq(0)
          end
        end
      end
    end
  end

  # SHOW =======================================================================
  describe 'GET show' do
    context 'when there are users' do
      before(:all) do
        @users = create_list(:valid_user, 3)
        @userx = @users[rand @users.count]
      end

      after(:all) do
        User.unscoped.delete_all
      end

      context 'the response' do
        before do
          get :show, id: @userx.id
        end

        specify 'is correct' do
          expect(response).to have_http_status(:ok)
        end

        describe 'body' do
          let(:body) { response.body }

          it 'has email and username info' do
            expect(body).to include(@userx.email)
            expect(body).to include(@userx.username)
          end
        end
      end
    end

    context 'when there are NO users' do
      context 'the response' do
        before do
          get :show, id: 1
        end

        specify 'is correct' do
          expect(response).to have_http_status(:ok)
        end

        describe 'body' do
          let(:body) { response.body }
          let(:json) { JSON.parse(body) }

          it 'has error' do
            expect(json.keys.first).to eq('error')
          end
        end
      end
    end
  end

  # DESTROY ====================================================================
  describe 'DELETE destroy' do
    context 'when there are users' do
      before(:all) do
        @users = create_list(:valid_user, 3)
        @userx = @users[rand @users.count]
      end

      after(:all) do
        User.unscoped.delete_all
      end

      it "deletes the contact" do
        expect{
          delete :destroy, id: @userx.id
        }.to change(User,:count).by(-1)
      end

      it "answers error when id is non-existent" do
        delete :destroy, id: -1
        json = JSON.parse(response.body)
        expect(json.keys.first).to eq('error')
      end
    end
  end

  # CREATE =====================================================================
  describe 'POST create' do

    after(:all) do
      User.unscoped.delete_all
    end

    context 'when there are no users' do
      it "creates the user" do
        expect{
          post :create, username: 'xxx', email: 'x@user.com'
        }.to change(User,:count).by(1)
      end

      it "fails to create the user without email" do
        post :create, username: 'xxx'
        json = JSON.parse(response.body)
        expect(json.keys.first).to eq('error')
      end
    end

    context 'when there are users' do
      before(:all) do
        @users = create_list(:valid_user, 3)
        @userx = @users[rand @users.count]
      end

      after(:all) do
        User.unscoped.delete_all
      end

      it "fails to create if duplicat email" do
        post :create, username: 'xxx', email: @userx.email
        json = JSON.parse(response.body)
        expect(json.keys.first).to eq('error')
      end
    end
  end

  # UPDATE =====================================================================
  describe 'PUT update' do

    after(:all) do
      User.unscoped.delete_all
    end

    context 'when there are no users' do
      it "fails to update the user" do
        put :update, id: 0, username: 'xxx', email: 'x@user.com'
        json = JSON.parse(response.body)
        expect(json.keys.first).to eq('error')
      end
    end

    context 'when there are users' do
      before(:all) do
        @users = create_list(:valid_user, 3)
        @userx = @users[0]
        @usery = @users[1]
      end

      after(:all) do
        User.unscoped.delete_all
      end

      it "updates successfully" do
        put :update, id: @userx.id, username: 'new', email: 'x@user.com'
        @userx.reload
        expect(@userx.username).to eq('new')
      end

      it "fails to update to duplicate email" do
        put :update, id: @userx.id, username: 'xxx', email: @usery.email
        @userx.reload
        json = JSON.parse(response.body)
        expect(json.keys.first).to eq('error')
        expect(@userx.email).not_to eq(@usery.email)
      end
    end
  end


end
