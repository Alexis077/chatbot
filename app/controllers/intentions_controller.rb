class IntentionsController < ApplicationController
  def create
    result = Intentions::Create.call(intentions_params: intentions_params, session: session)
    @messages = result.messages

    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  private

  def intentions_params
    params.permit(:input_text)
  end
end
