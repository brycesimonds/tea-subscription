class CustomerSubscription < ApplicationRecord
  validates_presence_of :status
  enum status: { "cancelled" => 0, "active" => 1 }
  
  belongs_to :customer
  belongs_to :subscription
end
