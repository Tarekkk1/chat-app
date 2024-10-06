class MessagesController < ApplicationController
  def create
    application = Application.find_by!(token: params[:application_token])
    chat = Chat.find_by!(application_token: application.token, chat_number: params[:chat_chat_number])

    MessageCreationJob.perform_later(chat.id, chat.chat_number, application.token, params[:body])

    render(
      json: {
        status: "success",
        message: "Message creation queued"
      },
      status: :accepted
    )
  rescue ActiveRecord::RecordNotFound => e
    render(
      json: {
        status: "error",
        message: e.message
      },
      status: :not_found
    )
  end

  def update
    application = Application.find_by!(token: params[:application_token])
    chat = Chat.find_by!(application_token: application.token, chat_number: params[:chat_chat_number])
    message = Message.find_by!(chat_id: chat.id, message_number: params[:message_number])

    message.update!(body: params[:body])

    render(
      json: {
        status: "success",
        message: MessageSerializer.new(message).to_hash[:data][:attributes],
      },
      status: :ok
    )
  rescue ActiveRecord::RecordNotFound => e
    render(
      json: {
        status: "error",
        message: e.message
      },
      status: :not_found
    )
  rescue ActiveRecord::RecordInvalid => e
    render(
      json: {
        status: "error",
        message: e.message
      },
      status: :unprocessable_entity
    )
  end

  def show
    application = Application.find_by!(token: params[:application_token])
    chat = Chat.find_by!(application_token: application.token, chat_number: params[:chat_chat_number])
    message = Message.find_by!(chat_id: chat.id, message_number: params[:message_number])

    render(
      json: {
        status: "success",
        message: MessageSerializer.new(message).to_hash[:data][:attributes],
      },
      status: :ok
    )
  rescue ActiveRecord::RecordNotFound => e
    render(
      json: {
        status: "error",
        message: e.message
      },
      status: :not_found
    )
  end

  def list
    application = Application.find_by!(token: params[:application_token])
    chat = Chat.find_by!(application_token: application.token, chat_number: params[:chat_number])
    messages = chat.messages

    render(
      json: {
        status: "success",
        messages: messages.map { |message| MessageSerializer.new(message).to_hash[:data][:attributes] },
      },
      status: :ok
    )
  rescue ActiveRecord::RecordNotFound => e
    render(
      json: {
        status: "error",
        message: e.message
      },
      status: :not_found
    )
  end

  def search

    application = Application.find_by!(token: params[:application_token])
    chat = Chat.find_by!(application_token: application.token, chat_number: params[:chat_chat_number]) 
    messages = Message.search({
      query: {
        bool: {
          must: [
            { match: { chat_number: chat.chat_number } },
            { match: { application_token: application.token } },
            { match: { body: params[:query] } }
          ]
        }
      }
    }).records
  
    render(
      json: {
        status: "success",
        messages: messages.map { |message| MessageSerializer.new(message).to_hash[:data][:attributes] }
      },
      status: :ok
    )
  rescue ActiveRecord::RecordNotFound => e
    render(
      json: {
        status: "error",
        message: e.message
      },
      status: :not_found
    )
  end
  
end
