class ApplicationsController < ApplicationController
  def create
    begin
      application = Application.create!(name: application_prams[:name], token: SecureRandom.hex(12))
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
        render(
          json: {
            status: "error",
            message: "Token can't be blank"
          },
          status: :unprocessable_entity
        )
        return
      end
      
      application = Application.find_by!(token: params[:token])
      render(
        json: {
          status: "success",
          application: ApplicationSerializer.new(application).to_hash[:data][:attributes],
        },
        status: :ok
      )
    rescue ActiveRecord::RecordNotFound
      render(
        json: {
          status: "error",
          message: "Application not found"
        },
        status: :not_found
      )
    end
  end
  
  def update
    if params[:token].blank?
      render(
        json: {
          status: "error",
          message: "Token can't be blank"
        },
        status: :unprocessable_entity
      )
      return
    end

    begin
      application = Application.find_by!(token: params[:token])

      if application.update(application_prams)
        render(
          json: {
            status: "success",
            application: ApplicationSerializer.new(application).to_hash[:data][:attributes],
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
      render(
        json: {
          status: "error",
          message: "Application not found with the provided token"
        },
        status: :not_found
      )
    end
  end

  private

  def application_prams
    params.require(:application).permit(:name)
  end
end
