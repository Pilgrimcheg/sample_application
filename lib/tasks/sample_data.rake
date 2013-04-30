namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin=User.create!(name: "Ivan  Pushkar",
                 email: "piligrimcheg@gmail.com",
                 password: "karl1991",
                 password_confirmation: "karl1991")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@example.ru"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
     end

    users = User.all(limit: 6)
    50.times do
      title = Faker::Lorem.sentence(5)
      room_description = "Maybe best room in the world"
      include_breakfast = true
      price = 566.3
      adress  = "Sevastopol"
      star_rate_hotel = 3
      users.each {|user| user.hotels.create!(title: title, room_description: room_description,
        include_breakfast: include_breakfast, price: price, adress: adress, star_rate_hotel: star_rate_hotel)}
    end
  end
end