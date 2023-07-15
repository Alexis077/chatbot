FactoryBot.define do
  factory :message do
    text { FFaker::Lorem.sentence }
    association :chat_session
  end
end