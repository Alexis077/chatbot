module Intention
 module DepositInquiry
  class Create

    def self.instruction_message
      I18n.t('intention.instructions')
    end

    def initialize(params)

    end

    def save!
    end
  end 
 end
end