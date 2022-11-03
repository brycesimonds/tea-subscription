# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@customer_1 = Customer.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  address: Faker::Address.full_address
  )
@customer_2 = Customer.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  address: Faker::Address.full_address
  )

@subscription_1 = Subscription.create!(
  title: "30 Day Subscription",
  price: 30.00,
  frequency: 12
  )
@subscription_2 = Subscription.create!(
  title: "60 Day Subscription",
  price: 60.00,
  frequency: 6
  )
@subscription_3 = Subscription.create!(
  title: "90 Day Subscription",
  price: 90.00,
  frequency: 4
  )

@tea_1 = Tea.create!(
  title: "Black Tea",
  description: Faker::Quote.yoda,
  temperature: 110.00,
  brew_time: 4,
  )
@tea_2 = Tea.create!(
  title: "Green Tea",
  description: Faker::Quote.yoda,
  temperature: 105.00,
  brew_time: 2,
  )
@tea_3 = Tea.create!(
  title: "Oolong Tea",
  description: Faker::Quote.yoda,
  temperature: 100.00,
  brew_time: 3,
  )
@tea_4 = Tea.create!(
  title: "Peppermint Tea",
  description: Faker::Quote.yoda,
  temperature: 120.00,
  brew_time: 5,
  )

CustomerSubscription.create!(customer_id: @customer_1.id, subscription_id: @subscription_1.id, status: 0)
@cust1_and_sub3 = CustomerSubscription.create!(customer_id: @customer_1.id, subscription_id: @subscription_3.id, status: 1)

SubscriptionTea.create!(subscription_id: @subscription_1.id, tea_id: @tea_1.id)
SubscriptionTea.create!(subscription_id: @subscription_2.id, tea_id: @tea_2.id)
SubscriptionTea.create!(subscription_id: @subscription_2.id, tea_id: @tea_3.id)
SubscriptionTea.create!(subscription_id: @subscription_3.id, tea_id: @tea_4.id)