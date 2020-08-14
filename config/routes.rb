Rails.application.routes.draw do
  
   root 'users#index'
   get '/index'=>'users#index' ,as: 'home'
   get '/admin' => 'admin#index', as: 'admin'
   get '/signup' => 'users#signup', as: 'signup'
   get '/login' => 'users#login', as: 'login'
   get '/appointment' => 'users#appointment', as: 'appointment'
   get '/cancel' => 'users#cancel', as: 'cancel'
   get '/logout' => 'users#logout', as: 'logout'
   get '/status' => 'admin#status', as: 'status'
   get '/status_done/:id' => 'admin#status_done', as: 'status_done'
   get '/appointmentdelete/:id' => 'users#appointmentdelete', as: 'appointmentdelete'
   get '/patch/:id'=>'admin#patch' ,as: 'patch'
   get '/edit/:id'=>'admin#edit' ,as: 'edit'
   patch '/doctors/:id'=>'admin#update',as: 'doctor'
   delete '/delete/:id'=>'admin#delete' ,as: 'delete'
   get '/register' => 'users#register'
   post '/register' => 'users#register'
   post '/order' => 'users#order'
   post '/new' => 'admin#new'
   get '/add' => 'admin#add'
   get '/new' => 'admin#index'
   post '/attempt_login' => 'admin#attempt_login'
   post '/attempt_ulogin' => 'users#attempt_ulogin'
   post '/forgot_form' => 'users#forgot_form'
   get '/forgot' => 'users#forgot'
   post '/add_slot' => 'admin#add_slot'
   post '/book_slot' => 'users#book_slot'
   get '/confirm' => 'users#confirm'
   resources :users
    resources :account_activations, only: [:edit]
   
   #resources :doctors
   match ':controller(/:action(/:id(.:format)))', :via => [:get,:post]
end
