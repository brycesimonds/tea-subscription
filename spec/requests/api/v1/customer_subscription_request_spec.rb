require 'rails_helper'

RSpec.describe "Customer Subscriptions Requests" do 
  before :each do
    @customer_1 = Customer.new(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      address: Faker::Address.full_address
      )
    @customer_2 = Customer.new(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      address: Faker::Address.full_address
      )

    @subscription_1 = Subscription.new(
      title: "30 Day Subscription",
      price: 30.00,
      frequency: 12
      )
    @subscription_2 = Subscription.new(
      title: "60 Day Subscription",
      price: 60.00,
      frequency: 6
      )

    CustomerSubscription.new(customer_id: @customer_1.id, subscription_id: @subscription_1.id, status: 0)

    @tea_1 = Tea.new(
      title: "Black Tea",
      description: Faker::Quote.yoda,
      temperature: 110.00,
      brew_time: 4,
      )
    @tea_2 = Tea.new(
      title: "Green Tea",
      description: Faker::Quote.yoda,
      temperature: 105.00,
      brew_time: 2,
      )
    @tea_3 = Tea.new(
      title: "Oolong Tea",
      description: Faker::Quote.yoda,
      temperature: 100.00,
      brew_time: 3,
      )

    SubscriptionTea.new(subscription_id: @subscription_1.id, tea_id: @tea_1.id)
    SubscriptionTea.new(subscription_id: @subscription_2.id, tea_id: @tea_2.id)
    SubscriptionTea.new(subscription_id: @subscription_2.id, tea_id: @tea_3.id)
  end

  describe 'An endpoint to subscribe a customer to a tea subscription' do 
    it 'subscribes a customer to a tea subscription' do 
      
      customer_subscription_params = ({
        customer_id: @customer_1.id,
        subscription_id: @subscription_2.id,
        status: '1',
        })
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/subscriptions/subscribe', headers: headers, params: JSON.generate(customer_subscription_params)

      expect(response).to be_successful 
      expect(response.status).to eq(201)
    end
  end
end