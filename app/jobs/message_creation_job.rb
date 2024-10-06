class MessageCreationJob < ApplicationJob
  queue_as :default

  def perform(chat_id, chat_number, application_token, body)
    chat = Chat.find(chat_id)

    chat.with_lock do
      Message.create!(
        chat_id: chat.id,
        chat_number: chat_number,
        application_token: application_token,
        message_number: chat.messages_count + 1,
        body: body
      )

      chat.increment!(:messages_count)
    end
  end
end
