class ApplicationsController < ApplicationController
  def create
    begin
      application = Application.create!(name: application_params[:name], token: SecureRandom.hex(12))
      Redis.current.del("application_#{application.token}")
      render(
        json: {
          status: "success",
          application: ApplicationSerializer.new(application).to_hash[:data][:attributes],
        },
        status: :created
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
  end

  def show
    begin
      if params[:token].blank?
        render(json: { status: "error", message: "Token can't be blank" }, status: :unprocessable_entity)
        return
      end

      application = Redis.current.get("application_#{params[:token]}")
      unless application
        application = Application.find_by!(token: params[:token])
        Redis.current.set("application_#{params[:token]}", application.to_json)
      else
        application = Application.new(JSON.parse(application))
      end

      render(
        json: {
          status: "success", 
          application: ApplicationSerializer.new(application).to_hash[:data][:attributes]
        },
        status: :ok
      )
    rescue ActiveRecord::RecordNotFound
      render(json: { status: "error", message: "Application not found" }, status: :not_found)
    end
  end

  def update
    if params[:token].blank?
      render(json: { status: "error", message: "Token can't be blank" }, status: :unprocessable_entity)
      return
    end

    begin
      application = Application.find_by!(token: params[:token])
      if application.update(application_params)
        Redis.current.del("application_#{params[:token]}")
        render(
          json: {
            status: "success",
            application: ApplicationSerializer.new(application).to_hash[:data][:attributes]
          },
          status: :ok
        )
      else
        render(
          json: {
            status: "error",
            message: application.errors.full_messages.to_sentence
          },
          status: :unprocessable_entity
        )
      end
    rescue ActiveRecord::RecordNotFound
      render(json: { status: "error", message: "Application not found with the provided token" }, status: :not_found)
    end
  end

  private

  def application_params
    params.require(:application).permit(:name)
  end
end
