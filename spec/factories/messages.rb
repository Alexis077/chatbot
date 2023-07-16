FactoryBot.define do
  factory :message do
    text { FFaker::Lorem.sentence }
    intention { "without_intention" }
    association :chat_session
  end
end