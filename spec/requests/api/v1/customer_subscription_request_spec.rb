require 'rails_helper'

RSpec.describe "Customer Subscriptions Requests" do 
  before :each do
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
  end

  describe 'An endpoint to subscribe a customer to a tea subscription' do 
    it 'subscribes a customer to a tea subscription' do 
      customer_subscription_params = ({
        "customer_id": "#{@customer_1.id}",
        "subscription_id": "#{@subscription_2.id}",
        "status": 1
        })
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/subscriptions/subscribe', headers: headers, params: JSON.generate(customer_subscription_params)

      expect(response).to be_successful 
      expect(response.status).to eq(201)

      created_association = CustomerSubscription.last 
      expect(created_association.customer_id).to eq(@customer_1.id)
      expect(created_association.subscription_id).to eq(@subscription_2.id)
      expect(created_association.status).to eq("active")
    end

    it 'returns 400 and does not create subscribe a customer to the tea subscription' do 
      customer_subscription_params = ({
        "customer_id": "#{@customer_1.id}",
        "subscription_id": "999999999",
        "status": 1
        })
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/subscriptions/subscribe', headers: headers, params: JSON.generate(customer_subscription_params)

      expect(response).to_not be_successful 
      expect(response.status).to eq(400)
    end
  end

  describe 'An endpoint to cancel a customers tea subscription' do 
    it 'sets status from active to cancelled for a customers tea subscription' do 
      customer_subscription_params = ({
        "customer_id": "#{@customer_1.id}",
        "subscription_id": "#{@subscription_3.id}",
        "status": 0
        })
      headers = {"CONTENT_TYPE" => "application/json"}
      patch '/api/v1/subscriptions/unsubscribe', headers: headers, params: JSON.generate(customer_subscription_params)

      updated_customer_subscription = CustomerSubscription.find_by(id: @cust1_and_sub3.id)
      expect(response).to be_successful
      expect(updated_customer_subscription.status).to eq('cancelled')
    end
  end 

  describe 'An endpoint to retrieve all tea subscriptions for a customer' do 
    it 'gets all a customers tea subscriptions regardless of status' do 

      get "/api/v1/customers/#{@customer_1.id}/subscriptions"

      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      tea_subscription_data = JSON.parse(response.body, symbolize_names: true)
      tea_subscription_data.map do |single_subscription| 
        expect(single_subscription).to have_key(:customer_id)
        expect(single_subscription[:customer_id]).to be_a(Integer)
        expect(single_subscription).to have_key(:subscription_id)
        expect(single_subscription[:subscription_id]).to be_a(Integer)
        expect(single_subscription).to have_key(:status)
        expect(single_subscription[:status]).to be_a(String)
      end 
    end
  end 
end