module Intention
  class Main
    INTENTIONS = {"deposit_inquiry" => DepositInquiry::Create } 
    
    def initialize(intention, chat_session)
      @intention = intention
      @chat_session = chat_session
    end
    
    def instruction_message
      @chat_session.update!(status: :processing_request)
      INTENTIONS[@intention].instruction_message
    end

    def execute!

    end
  end
end