class Api::V1::CustomerSubscriptionsController < ApplicationController
  before_action :subscription_params, only: [:create]

  def index
    customer = Customer.find(params[:id])
    render json: customer.customer_subscriptions
  end
  
  def create
    add_subscription_to_customer = CustomerSubscription.new(subscription_params)
    if add_subscription_to_customer.save
      render json: SubscriptionSerializer.subscribe(add_subscription_to_customer), status: 201
    else
      render status: 400
    end
  end

  def update
    customer_subscription = CustomerSubscription.where(customer_id: params[:customer_id], subscription_id: params[:subscription_id]).first
    customer_subscription.update!(subscription_params)
    render json: customer_subscription
  end

  private

  def subscription_params
    JSON.parse(request.raw_post, symbolize_names: true)
  end
end