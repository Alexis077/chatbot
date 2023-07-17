# frozen_string_literal: true

module Intention
  module DepositInquiry
    class Create
      include ActiveModel::Model

      attr_reader :rut, :deposit_date, :customer, :errors_messages

      validates :rut, presence: { message: I18n.t('intention.deposit_inquiry.errors.rut_must_exist') }
      validates :deposit_date, presence: { message: I18n.t('intention.deposit_inquiry.errors.date_must_exist') },
                               format: { with: %r{\A\d{2}/\d{2}/\d{4}\z}, message: I18n.t('intention.deposit_inquiry.errors.date_invalid_format') }

      def self.instruction_message
        I18n.t('intention.deposit_inquiry.instructions')
      end

      def initialize(params, chat_session)
        @errors_messages = []
        @params = params
        @chat_session = chat_session
        sanitize!
      end

      def execute!
        return Result.new(valid: true, message: I18n.t('hello_message_for_chat')) if cancel_process?

        validate
        return Result.new(valid: false, errors: @errors_messages) if @errors_messages.any?

        get_purchase_request!
      end

      private

      def sanitize!
        data = @params.strip.split(';')
        @rut = data[0]&.strip
        @deposit_date = data[1]&.strip
      end

      def validate
        @errors_messages << errors.messages.values unless valid?
        @customer = ::Customer.find_by(rut: @rut)
        @errors_messages << I18n.t('intention.deposit_inquiry.errors.rut_must_exist') unless customer.present?
      end

      def get_purchase_request!
        purchase_request = @customer.purchase_requests.find_by(deposit_date: Date.strptime(@deposit_date, '%d/%m/%Y'))
        if purchase_request.present?
          @chat_session.update!(status: :finished)
          Result.new(valid: true,
                     message: I18n.t('intention.deposit_inquiry.deposit_amount',
                                     date: purchase_request.deposit_date.strftime('%d/%m/%Y'),
                                     deposit_amount: purchase_request.total))
        else
          Result.new(valid: false,
                     message: I18n.t('intention.deposit_inquiry.errors.not_found',
                                     date: purchase_request.deposit_date.strftime('%d/%m/%Y'),
                                     deposit_amount: purchase_request.total))
        end
      end

      def cancel_process?
        data = @params.strip.split(';')

        if data[0]&.strip&.downcase.eql?('cancelar') || data[0]&.strip&.downcase.eql?('cancel')
          @chat_session.update!(status: :initialized)
          true
        else
          false
        end
      end
    end
  end
end
