# frozen_string_literal: true

module Errors
  module Handler
    extend ActiveSupport::Concern

    def handle_error
      return if context.failure?

      context.fail!(error: I18n.t('errors.critical_error'))
    end
  end
end
  