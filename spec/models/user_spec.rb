require 'rails_helper'

describe User do
  describe 'instantiation' do
    let!(:user) { build(:user) }

    it 'instantiates an user' do
      expect(user.class.name).to eq('User')
    end
  end

  describe 'validation' do

    it 'is valid when it has username and email' do
      u = build(:user, username: 'u', email: 'u@user.com')
      expect(u).to be_valid
    end

    it 'is invalid without email' do
      u = build(:user, email: 'u@user.com')
      expect(u).not_to be_valid
    end

    it 'is invalid with duplicate email' do
      create(:user, email: 'u@user.com', username: 'u2')
      u = build(:user, email: 'u@user.com', username: 'u')
      expect(u).not_to be_valid
    end

    it 'is valid without duplicate email' do
      create(:user, email: 'u2@user.com', username: 'u2')
      u = build(:user, email: 'u@user.com', username: 'u')
      expect(u).to be_valid
    end
  end
end
