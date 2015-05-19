require 'faker'

# Create Users
5.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create Premium Users
5.times do
  premium_user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "premium_rocks",
    role: "premium"
    )
  premium_user.skip_confirmation!
  premium_user.save!
end

# Create Wikis
500.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    tag_list: Faker::Lorem.word,
    body: Faker::Lorem.paragraph,
    user: users.sample
  )
end

# Create Admin account
admin = User.new(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'helloworld',
  role: 'admin'
  )
admin.skip_confirmation!
admin.save!

# Create Premium account
premium = User.new(
  name: 'Premium User',
  email: 'premium@example.com',
  password: 'helloworld',
  role: 'premium'
  )
premium.skip_confirmation!
premium.save!

# Create Standard account
standard = User.new(
  name: 'Standard User',
  email: 'standard@example.com',
  password: 'helloworld',
  role: 'standard'
  )
standard.skip_confirmation!
standard.save!

puts "Seed finished"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"