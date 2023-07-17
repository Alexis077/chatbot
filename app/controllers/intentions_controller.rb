# frozen_string_literal: true

class IntentionsController < ApplicationController
  def create
    result = Intentions::Create.call(intentions_params: intentions_params, session: session)
    @messages = result.messages
    @customers = Customer.all
    respond_to(&:js)
  end

  private

  def intentions_params
    params.permit(:input_text)
  end
end
