class IntentionsController < ApplicationController
  def create
    Intentions::Create.call(intentions_params)
    render "home/index"
  end

  private

  def intentions_params
    params.permit(:input_text)
  end
end
