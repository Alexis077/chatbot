class Intentions::Create
  include Interactor
  
  before do 
    context.messages = []  
    context.errors = []
  end
  
  def call
    get_chat_session!
    process_request!
    get_messages
  rescue => ex
    binding.pry
    Rails.logger.error(ex.message)
  end

  private

  def get_chat_session!
    context.session[:session_id] ||= ULID.generate
    context.chat_session = ChatSession.find_or_create_by!(session_id: context.session[:session_id], status: :initialized)
  end

  def get_messages
    context.messages = context.chat_session.messages.order(id: :asc)
  end
  
  def process_request!
    validate_chat_session_for_input_text! if context.chat_session.initialized?
    return set_message!(context.errors.join("\n")) if context.errors.any?
    response = ::Intention::Main.new(context.intentions_params[:input_text]).execute!
    set_message!(response)
  end

  def validate_chat_session_for_input_text!
    validator = Intentions::Validators::Initialized.new(input_text: context.intentions_params[:input_text])
    context.errors = validator.errors.messages.values unless validator.valid?
  end

  def set_message!(text)
    Message.create!(chat_session: context.chat_session, text: text)
  end
end
  