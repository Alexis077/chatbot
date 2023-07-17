class HomeController < ApplicationController
  
  def index
    result = Home::Index.call(session: session)
    @messages = result.messages
    @customers = Customer.all
  end
end
