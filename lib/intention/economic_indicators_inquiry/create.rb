# frozen_string_literal: true

module Intention
  module EconomicIndicatorsInquiry
    class Create
      include ActiveModel::Model

      EXCHANGE_RATE_URLS = { dollar: 'https://mindicador.cl/api/dolar',
                             utm: 'https://mindicador.cl/api/utm',
                             uf: 'https://mindicador.cl/api/uf' }.freeze

      attr_reader :selected_option

      validates :selected_option,
                presence: { message: I18n.t('intention.economic_indicators_inquiry.errors.select_an_option') }

      validate :validate_selected_option!

      def self.instruction_message
        I18n.t('intention.economic_indicators_inquiry.instructions')
      end

      def initialize(params, chat_session)
        @selected_option = params.strip.downcase
        @errors_messages = []
        @chat_session = chat_session
      end

      def execute!
        return Result.new(valid: true, message: I18n.t('hello_message_for_chat')) if cancel_process?
        return Result.new(valid: false, errors: [I18n.t('intention.errors.not_valid_option')]) unless valid?

        dollar_value = get_exchange_rate(:dollar)
        utm_value = get_exchange_rate(:utm)
        uf_value = get_exchange_rate(:uf)
        @chat_session.update!(status: :finished)
        Result.new(valid: true, message: I18n.t('intention.economic_indicators_inquiry.rate_message',
                                                dollar_value: dollar_value,
                                                utm_value: utm_value,
                                                uf_value: uf_value))
      end

      private

      def validate_selected_option!
        valid_options = %w[si no yes]
        errors.add(:selected_option, I18n.t('intention.errors.not_valid_option')) unless valid_options.include?(@selected_option)
      end

      def get_exchange_rate(rate)
        response = HTTParty.get(EXCHANGE_RATE_URLS[rate])
        data = JSON.parse(response.body)
        data['serie'].first['valor']
      end

      def cancel_process?
        if @selected_option.eql?('no') 
          @chat_session.update!(status: :initialized)
          true
        else
          false
        end
      end
    end
  end
end
