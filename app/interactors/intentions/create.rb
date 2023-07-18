# frozen_string_literal: true

module Intentions
  class Create
    include Interactor
    include Errors::Handler
    
    VALID_INTENTIONS = { '1' => 'deposit_inquiry', '2' => 'request_paper_rolls',
                         '3' => 'economic_indicators_inquiry' }.freeze

    before do
      context.messages = []
      context.errors = []
    end

    def call
      get_chat_session!
      process_request!
      get_messages
    rescue StandardError => e
      handle_error
      Rails.logger.error(e.message)
    end

    private

    def get_chat_session!
      context.session[:session_id] ||= ULID.generate
      context.chat_session = ChatSession.find_or_create_by!(session_id: context.session[:session_id])
    end

    def get_messages
      context.messages = context.chat_session.messages.order(id: :asc)
    end

    def process_request!
      if context.chat_session.initialized?
        validate_chat_session_for_input_text!
        return set_message!(context.errors.join("\n")) if context.errors.any?

        intention = VALID_INTENTIONS[context.intentions_params[:input_text]]
        return set_message!(I18n.t('intention.errors.not_valid_option')) if intention.nil?

        response = ::Intention::Main.new(intention, context.chat_session).instruction_message
        set_message!(response, intention)
      elsif context.chat_session.finished?
        context.chat_session.update!(status: :initialized)
        set_message!(I18n.t('finished_operation'))
      else
        intention = context.chat_session.messages.last.intention
        response = ::Intention::Main.new(intention,
                                         context.chat_session, context.intentions_params[:input_text], context.extras).execute!
        return set_message!(response.errors.join("\n"), intention) if response.errors.any?

        set_message!(response.message, :without_intention)
      end
    end

    def validate_chat_session_for_input_text!
      validator = Intentions::Validators::Initialized.new(input_text: context.intentions_params[:input_text])
      context.errors = validator.errors.messages.values unless validator.valid?
    end

    def set_message!(text, intention = :without_intention)
      Message.create!(chat_session: context.chat_session, text: text, intention: intention)
    end
  end
end
