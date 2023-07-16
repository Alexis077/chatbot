FactoryBot.define do
  factory :purchase_request do
    address { FFaker::Address.street_address }
    amount { rand(1..10) }
    quantity { rand(1..5) }
    total { amount * quantity }
    association :customer, factory: :customer
  end
end