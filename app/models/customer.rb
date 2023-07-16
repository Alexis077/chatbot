class Customer < ApplicationRecord
  belongs_to :account
  has_many :purchase_requests
end
