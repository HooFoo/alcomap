Rails.application.routes.draw do
  resources :profiles, defaults: {format: :json}
  #resources :media
  resources :settings, defaults: {format: :json}
  resources :chat_messages, defaults: {format: :json}
  devise_for :users, controllers: {registrations: 'users/registrations',
                                   invitations: 'users/invitations'},
             path_names: {sign_up: '',}
  get 'index_controller/index'
  post 'users/invitation', to: 'users/invitations#update'
  get 'users/success', to: 'users/invitations#success'
  post 'points/rate/:id', to: 'points#rate', defaults: {format: :json}
  post 'points/get_points', to: 'points#get_points'
  get '/user', to: 'user#index', defaults: {format: :json}
  get '/user/onlinecount', to: 'user#online_count', defaults: {format: :json}
  get '/chat_messages/latest/:id', to: 'chat_messages#latest', defaults: {format: :json}
  get '/news/latest/:id', to: 'news#latest', defaults: {format: :json}
  get '/news', to: 'news#index', defaults: {format: :json}
  get '/news/my/(:shift)', to: 'news#my', defaults: {shift: 0, format: :json}
  get '/profiles/by_user/:user_id', to: 'profiles#by_user', defaults: {shift: 0, format: :json}
  resources :comments, defaults: {format: :json}
  resources :points, defaults: {format: :json}

  root 'index#index'

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
