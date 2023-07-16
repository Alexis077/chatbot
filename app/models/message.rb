class Message < ApplicationRecord
  belongs_to :chat_session

  enum intention: { without_intention: "without_intention",
                    deposit_inquiry: "deposit_inquiry",
                    request_paper_rolls: "request_paper_rolls",
                    economic_indicators_inquiry: "economic_indicators_inquiry" }
  validates :text, allow_blank: false, presence: true
  validates :intention, inclusion: { in: intentions.keys }
end
