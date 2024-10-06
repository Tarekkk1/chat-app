class MessageSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :body, :chat_number, :application_token, :message_number
    
end
