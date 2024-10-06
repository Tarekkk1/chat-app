class ChatSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :chat_number, :application_token, :messages_count
    
  end
