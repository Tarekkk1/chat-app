Rails.application.routes.draw do
  resources :messages, only: [:create, :update, :show, :index] do
    collection do
      get 'list'
      get 'search'
    end
  end

  resources :chats, only: [:create, :index, :show]

  resources :applications, param: :token, only: [:create, :show, :update]

  get "about", to: "about#index"
end
