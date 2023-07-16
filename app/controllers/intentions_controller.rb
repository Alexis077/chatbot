class IntentionsController < ApplicationController
  def create
    result = Intentions::Create.call(intentions_params: intentions_params, session: session)
    @messages = result.messages
    redirect_to root_path
  end

  private

  def intentions_params
    params.permit(:input_text)
  end
end
