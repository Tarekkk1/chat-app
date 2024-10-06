class MessageCreationJob < ApplicationJob
  queue_as :default

  def perform(chat_id, chat_number, application_token, body)
    chat = Chat.find(chat_id)
    message_number = chat.messages_count + 1

    Message.create!(
      chat_id: chat_id,
      chat_number: chat_number,
      application_token: application_token,
      message_number: message_number,
      body: body
    )

    chat.increment!(:messages_count)
  end
end
