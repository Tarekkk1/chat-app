Rails.application.routes.draw do
  resources :applications, param: :token, only: [:create, :show, :update] do
    resources :chats, only: [:create, :index, :show], param: :chat_number do
      member do
        get 'list', to: 'messages#list'
      end

      resources :messages, param: :message_number, only: [:create, :index, :show, :update] do
        collection do
          get 'search'
        end
      end
    end
  end
end
