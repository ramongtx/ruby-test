FactoryGirl.define do
  factory :user do
    factory :valid_user do
      sequence(:username) {|n| "User #{n}"}
      sequence(:email) {|n| "user#{n}@user.com"}
      sequence(:password) {|n| "pass#{n}"}
    end
  end
end
