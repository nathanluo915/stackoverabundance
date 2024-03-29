Rails.application.routes.draw do

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  get 'questions/empty-check-mark' => 'questions#empty_check_mark'
  resource :sessions, only: [:create]
  resources :users, only: [:create,:show,:edit,:update,:destroy]

  resources :questions do
    collection do
      get 'list'
    end
    resources :answers, only:[:create, :new]
  end
  resources :comments, only:[:create]
  patch 'questions/:id' => 'questions#update'
  post 'questions/:id/votes' => 'votes#create', as: :question_votes
  post 'answers/:id/votes' => 'votes#create', as: :answer_votes
  post 'comments/:id/votes' => 'votes#create', as: :comment_votes

  put 'votes/:id' => 'votes#update'
  delete 'votes/:id' => 'votes#destroy'
  # resources :votes
  root "questions#index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
