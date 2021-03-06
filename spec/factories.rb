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

   factory :another_user do
   sequence(:name) { |n| "Persn #{n}" }
   sequence(:email) { |n| "Persn_#{n}@example.com" }
   password "karl11"
   password_confirmation "karl11"
 end

    factory :hotel do
      title "Hilton"
      room_description "Very beuty"
      include_breakfast true
      price 3258.2
      adress "fiol str."
      star_rate_hotel "3"
      user
    end
end