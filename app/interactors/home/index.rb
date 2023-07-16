class Home::Index
  include Interactor

  before do 
    context.messages = []  
  end
  
  def call
    get_chat_session!
    context.messages = context.chat_session.messages
  end

  private

  def get_chat_session!
    context.chat_session = ChatSession.find_by!(session_id: context.session[:session_id])
  end
end
  