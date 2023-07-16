FactoryBot.define do
  factory :chat_session do
    session_id { FFaker::Lorem.characters(10) }
    status { :initialized }
  end
end