class AddIndexesToMessagesAndChats < ActiveRecord::Migration[5.0]
  def change
    add_index :messages, [:chat_number, :application_token]
    add_index :chats, :application_token
    add_index :chats, :chat_number
  end
end
