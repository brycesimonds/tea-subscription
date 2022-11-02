class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :address

  has_many :customer_subscriptions
  has_many :subscriptions, through: :customer_subscriptions
  has_many :subscription_teas, through: :subscriptions
  has_many :teas, through: :subscription_teas
end
