class ApplicationSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :name, :token, :chats_count
    
  end
