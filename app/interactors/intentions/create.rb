class Intentions::Create
  include Interactor

  before do 
    context.messages = []  
  end
  
  def call
    get_chat_session!
    create_message!
    get_messages
  end

  private

  def get_chat_session!
    context.session[:session_id] ||= ULID.generate
    context.chat_session = ChatSession.find_or_create_by!(session_id: context.session[:session_id], status: :initialized)
  end

  def create_message!
    Message.create(chat_session: context.chat_session, text: context.intentions_params[:input_text])
  end

  def get_messages
    context.messages = context.chat_session.messages.order(id: :asc)
  end
end
  