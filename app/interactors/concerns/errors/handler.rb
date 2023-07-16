# frozen_string_literal: true

module Errors
  module Handler
    extend ActiveSupport::Concern

    def handle_error(errors)
      return if context.failure?

      context.fail!(errors: errors)
    end
  end
end
  