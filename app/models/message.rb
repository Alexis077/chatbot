class Message < ApplicationRecord
  validates :text, allow_blank: false, presence: true

  belongs_to :chat_session
end
