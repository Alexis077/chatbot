module Intention
  class Main
    INTENTIONS = {"deposit_inquiry" => DepositInquiry::Create } 
    
    def initialize(intention, chat_session, params = {})
      @intention = intention
      @chat_session = chat_session
      @params = params
    end

    def instruction_message
      @chat_session.update!(status: :processing_request)
      INTENTIONS[@intention].instruction_message
    end

    def execute!
      INTENTIONS[@intention].new(@params).execute!
    end
  end
end