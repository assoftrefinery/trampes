Rails.application.routes.draw do

  #mostrar tabla con controles de tal tipo
  get '/mostrar_tabla_control' => 'controls#mostrar_tabla_control'

  #asignar fabricacion a cabecera
  get '/asignar_fabricacion', :to=>"controls#asignar_fabricacion"

  #ruta para la duplicacion de registros
  get 'controls/duplicar_registro/' => 'controls#duplicar_registro'

  #Si pongo esto al final, peta. Muestra SHOW en vez de #planning
  get 'controls/planning/' => 'controls#planning'

  #Ruta para la exportacion de CONTROLES, comprobar si hay que cambiar la palabra 'exportar' para que no se confunda
  #con otros exports
  get 'exportar', to: 'controls#exportar', as: :controls_exportar

  resources :product_types
  resources :controls
  resources :vidres
  resources :auditvs
  resources :trampas
  resources :audits
  get 'home/principal'
  get 'home/menu_qualitat' => "home#menu_qualitat"
  get 'home/index' => "home#index"
  get 'home/menu_auditories' => "home#menu_auditories"


  #match ':controls/:planning', :via => [:get]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root :to => "home#principal"

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
