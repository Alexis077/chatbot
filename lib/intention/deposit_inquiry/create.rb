module Intention
 module DepositInquiry
  class Create
    include ActiveModel::Model
    
    def self.instruction_message
      I18n.t('intention.instructions')
    end

    def initialize(params)
      @params = params
    end

    def execute!
    end
  end 
 end
end