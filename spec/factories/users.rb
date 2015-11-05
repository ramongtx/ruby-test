require 'securerandom'

FactoryGirl.define do
  factory :user do
    factory :valid_user do
      sequence(:username) {|n| "User#{n}"}
      sequence(:email) {|n| "user#{n}@user.com"}
      sequence(:password) {|n| "password#{n}"}
    end
    factory :random_user do
      sequence(:username) {|n| SecureRandom.hex(12)+"#{n}"}
      sequence(:email) {|n| SecureRandom.hex(12)+"#{n}@rnd.com"}
      sequence(:password) {|n| "password#{n}"}
    end
  end
end
