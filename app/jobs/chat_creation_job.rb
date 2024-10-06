class ChatCreationJob < ApplicationJob
  queue_as :default

  def perform(application_id, application_token)
    application = Application.find(application_id)

    application.with_lock do
      application.increment!(:chats_count)

      Chat.create!(
        application_id: application.id,
        application_token: application_token,
        chat_number: application.chats_count
      )
    end
  end
end
