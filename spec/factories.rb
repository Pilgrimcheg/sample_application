FactoryGirl.define do
  factory :user do
   sequence(:name) { |n| "Person #{n}" }
   sequence(:email) { |n| "Person_#{n}@example.com" }
   password "karl1991"
   password_confirmation "karl1991"

   factory :admin do
    admin true
  end
  end
end