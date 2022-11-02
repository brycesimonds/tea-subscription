class AddStatusToCustomerSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :customer_subscriptions, :status, :integer
  end
end
