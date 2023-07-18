# frozen_string_literal: true

module Intention
  class Main
    INTENTIONS = { 'deposit_inquiry' => DepositInquiry::Create, 'request_paper_rolls' => RequestPaperRolls::Create,
                   'economic_indicators_inquiry' => EconomicIndicatorsInquiry::Create }.freeze

    def initialize(intention, chat_session, params = {}, extras = {})
      @intention = intention
      @chat_session = chat_session
      @params = params
      @extras = extras
    end

    def instruction_message
      @chat_session.update!(status: :processing_request)
      INTENTIONS[@intention].instruction_message
    end

    def execute!
      INTENTIONS[@intention].new(@params, @chat_session, @extras).execute!
    end
  end
end
