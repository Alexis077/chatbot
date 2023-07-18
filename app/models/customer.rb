class Customer < ApplicationRecord
  belongs_to :account
  has_many :purchase_requests

  def full_name
    "#{name} #{last_name}"
  end
end
