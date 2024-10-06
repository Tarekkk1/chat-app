Rails.application.routes.draw do
  resources :applications, param: :token, only: [:create, :show, :update] do
    resources :chats, only: [:create, :index, :show], param: :chat_number do
      resources :messages, only: [:create, :index, :show] do
        collection do
          get 'search'
        end
      end
    end
  end

  get "about", to: "about#index"
end
