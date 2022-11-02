class Api::V1::SubscriptionsController < ApplicationController
  before_action :find_customer, only: [:create]

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

  def find_customer
    @customer = Customer.find(params[:customer_id])
  end

  private

  def subscription_params
    params.permit(:customer_id, :subscription_id, :status)
  end
end