class ChatsController < ApplicationController
  def create
      application = Application.find_by!(token: params[:application_token])

      application.increment!(:chats_count)

      chat = Chat.create!(
        application_id: application.id,
        application_token: application.token,
        chat_number: application.chats_count
      )

      render(
        json: {
          status: "success",
          chat: ChatSerializer.new(chat).to_hash[:data][:attributes],
        },
        status: :created
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

  def index
    application = Application.find_by!(token: params[:application_token])
    chats = application.chats

    render(
      json: {
        status: "success",
        chats: chats.map { |chat| ChatSerializer.new(chat).to_hash[:data][:attributes] },
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

  def show
    application = Application.find_by!(token: params[:application_token])
    chat = application.chats.find_by!(chat_number: params[:chat_number])

    render(
      json: {
        status: "success",
        chat: ChatSerializer.new(chat).to_hash[:data][:attributes],
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
