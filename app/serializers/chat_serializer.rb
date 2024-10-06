class ChatSerializer
    include FastJsonapi::ObjectSerializer
    attributes :chat_number, :application_token, :messages_count
    
  end
