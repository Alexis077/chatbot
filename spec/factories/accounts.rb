FactoryBot.define do
  factory :account do
    balance { rand(1000..10000) }
  end
end
