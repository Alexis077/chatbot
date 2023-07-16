class ChatSession < ApplicationRecord
  enum status: { initialized: "initialized", processing_request: "processing_request", finished: "finished" }

  validates :session_id, presence: true
  validates :status, inclusion: { in: statuses.keys }
  
  has_many :messages
end