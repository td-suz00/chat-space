Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'groups#index'
  resources :users, only: [:edit, :update, :index]
  resources :groups, only: [:new, :create, :edit, :update, :index] do
    resources :messages, only: [:index, :create]

    # namespace :ディレクトリ名 do ~ endと囲む形でルーティングを記述すると、そのディレクトリ内のコントローラのアクションを指定
    namespace :api do
      # defaultsオプションを利用して、このルーティングが来たらjson形式でレスポンスするよう指定
      resources :messages, only: :index, defaults: { format: 'json' }
    end
  end

end


