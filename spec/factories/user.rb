FactoryGirl.define do
  factory :user do
    email "test@test.com"
    password "12345678"
    password_confirmation "12345678"

    factory :userina do
      email "testina@testina.com"
    end
  end
end