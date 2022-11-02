class ChangeForeignKeyForCustomerSubscription < ActiveRecord::Migration[5.2]
  def change
    rename_column :customer_subscriptions, :subscriptions_id, :subscription_id
  end
end
