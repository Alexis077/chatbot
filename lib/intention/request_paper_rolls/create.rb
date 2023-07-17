# frozen_string_literal: true

module Intention
  module RequestPaperRolls
    class Create
      include ActiveModel::Model

      FIXED_PURCHASE_AMOUNT = 700

      attr_reader :errors_messages, :rut, :address, :quantity, :customer, :chat_session

      validates :rut, presence: { message: I18n.t('intention.request_paper_rolls.errors.rut_must_exist') }
      validates :address, presence: { message: I18n.t('intention.request_paper_rolls.errors.address_must_exist') }
      validates :quantity,
                numericality: { only_integer: true,
                                message: I18n.t('intention.request_paper_rolls.errors.invalid_quantity') }

      def self.instruction_message
        I18n.t('intention.request_paper_rolls.instructions')
      end

      def initialize(params, chat_session)
        @params = params
        @errors_messages = []
        @rut = nil
        @address = nil
        @quantity = nil
        @chat_session = chat_session
        sanitize!
      end

      def execute!
        return Result.new(valid: true, message: I18n.t('hello_message_for_chat')) if cancel_process?

        validate
        return Result.new(valid: false, errors: @errors_messages) if @errors_messages.any?

        create_purchase_request!
      end

      private

      def sanitize!
        data = @params.strip.split(';')
        @rut = data[0]&.strip
        @address = data[1]&.strip
        @quantity = data[2]&.strip
      end

      def validate
        @errors_messages << errors.messages.values unless valid?
        @customer = ::Customer.find_by(rut: @rut)
        @errors_messages << I18n.t('intention.request_paper_rolls.errors.rut_must_exist') unless customer.present?
      end

      def create_purchase_request!
        total = @quantity.to_i * FIXED_PURCHASE_AMOUNT
        balance = @customer.account.balance
        if (balance - total) <= 0
          return Result.new(valid: false,
                            errors: [I18n.t('intention.request_paper_rolls.insufficient_balance')])
        end

        PurchaseRequest.create!(customer: @customer,
                                address: @address,
                                amount: FIXED_PURCHASE_AMOUNT,
                                quantity: @quantity,
                                total: total,
                                deposit_date: Time.zone.now + 1.days)
        @chat_session.update!(status: :finished)
        Result.new(valid: true, message: I18n.t('intention.request_paper_rolls.success_message'))
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
