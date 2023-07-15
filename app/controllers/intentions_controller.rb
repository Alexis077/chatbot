class IntentionsController < ApplicationController
  def create
    result = Intentions::Create.call(intentions_params)
    @messages = result.messages
    render "home/index"
  end

  private

  def intentions_params
    params.permit(:input_text)
  end
end
