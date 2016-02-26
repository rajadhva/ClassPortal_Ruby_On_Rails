Rails.application.routes.draw do

  get 'history/show'

  resources :subscribes
  resources :conversations do
  resources :messages
 end
 
  get 'requests/new' => 'requests#new'
  post 'requests/create' => 'requests#create'
  get 'requests/index' => 'requests#index'
  put 'requests/update' => 'requests#update'

  get 'courses/search' => 'courses#search'
  get 'courses/index' => 'courses#index'
  get 'courses/new' => 'courses#new'
  get 'courses/show' => 'courses#show'
  get 'courses/edit' => 'courses#edit'
  delete 'courses' => 'courses#destroy'

  get 'users/search' => 'users#search'
  get 'users/index' => 'users#index'
  get 'users/new' => 'users#new'
  get 'users/show' => 'users#show'
  get 'users/edit' => 'users#edit'
  get 'users/password' => 'users#password'
  patch 'users/update_password' => 'users#update_password'
  patch 'users/update' => 'users#update'
  delete 'users'  => 'users#destroy'
  
  get 'admins/index' => 'admins#index'
  get 'admins/show' => 'admins#show'
  get 'admins/edit' => 'admins#edit'
  delete 'admins'  => 'admins#destroy'

  get 'instructors/index' => 'instructors#index'
  get 'instructors/show' => 'instructors#show'
  get 'instructors/edit' => 'instructors#edit'
  delete 'instructors'  => 'instructors#destroy'

  get 'students/index' => 'students#index'
  get 'students/show' => 'students#show'
  get 'students/edit' => 'students#edit'
  delete 'students'  => 'students#destroy'
  
  get 'instructors/view' => 'instructors#view'

  get 'enrollments/index' => 'enrollments#index'
  get 'enrollments/grades' => 'enrollments#grades'
  delete 'enrollments' => 'enrollments#destroy'

  resource :users
  resources :course_instructors
  resources :enrollments
  resources :courses do
    resources :references
  end
  resources :requests

  devise_for :users, :controllers => {registrations: 'registrations'}

  root 'static_pages#new'
  get 'static_pages/about'
  get 'static_pages/todo'

   
  get 'admins/welcome'
  get 'instructors/welcome'
  get 'students/welcome'
  

# devise_for :users, :skip => [:sessions]
 # as :user do
  #  get 'signin' => 'devise/sessions#new', :as => :new_user_session
   # post 'signin' => 'devise/sessions#create', :as => :user_session
   # match 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session,
   #   :via => Devise.mappings[:user].sign_out_via
 # end


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
