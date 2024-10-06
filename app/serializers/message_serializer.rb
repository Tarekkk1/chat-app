class MessageSerializer
    include FastJsonapi::ObjectSerializer
    attributes :body, :chat_number, :application_token, :message_number
    
end
