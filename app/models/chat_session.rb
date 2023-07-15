class ChatSession < ApplicationRecord
  enum status: { open: "open", closed: "closed" }

  validates :session_id, presence: true
  validates :status, inclusion: { in: statuses.keys }
end