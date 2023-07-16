module Intentions
  module Validators
    class Initialized
      include ActiveModel::Model

      attr_reader :input_text

      validates :input_text, allow_blank: false, presence: true
      validates :input_text, numericality: { only_integer: true, message: I18n.t('intention.errors.not_valid_option') }

      def initialize(params={})
        @input_text = params[:input_text].strip
      end
    end
  end
end