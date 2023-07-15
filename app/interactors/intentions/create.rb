class Intentions::Create
  include Interactor
  
  def call
    context.messages = []
  end
end
  