class SubscriptionSerializer
  class << self
    def subscribe(customer_subscription_details)
      {
        data:
          {
            id: "#{customer_subscription_details.id}",
            type: "subscription",
            attributes: {
              customer_id: customer_subscription_details.customer_id,
              subscription_id: customer_subscription_details.subscription_id,
              status: customer_subscription_details.status
              }
            }
      }
    end
  end
end
