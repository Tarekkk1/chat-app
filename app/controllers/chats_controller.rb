class ChatsController < ApplicationController
  def create
    application = Application.find_by!(token: params[:application_token])
  
    Redis.current.del("chats_for_application_#{application.token}")

    ChatCreationJob.perform_later(application.id, application.token)

    render(json: { status: "success", message: "Chat creation queued" }, status: :accepted)
  rescue ActiveRecord::RecordNotFound => e
    render(json: { status: "error", message: e.message }, status: :not_found)
  end

  def index
    application = Application.find_by!(token: params[:application_token])

    chats = Redis.current.get("chats_for_application_#{application.token}")
    unless chats
      chats = application.chats
      Redis.current.set("chats_for_application_#{application.token}", chats.to_json)
    else
      chats = JSON.parse(chats).map { |chat| Chat.new(chat) }
    end

    render(
      json: {
        status: "success",
        chats: chats.map { |chat| ChatSerializer.new(chat).to_hash[:data][:attributes] }
      },
      status: :ok
    )
  rescue ActiveRecord::RecordNotFound => e
    render(json: { status: "error", message: e.message }, status: :not_found)
  end

  def show
    application = Application.find_by!(token: params[:application_token])
    chat = application.chats.find_by!(chat_number: params[:chat_number])

    render(json: { status: "success", chat: ChatSerializer.new(chat).to_hash[:data][:attributes] }, status: :ok)
  rescue ActiveRecord::RecordNotFound => e
    render(json: { status: "error", message: e.message }, status: :not_found)
  end
end
