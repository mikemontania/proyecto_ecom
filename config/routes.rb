# frozen_string_literal: true

devise_override_paths = {
  registration: 'r',
  sign_up: 'registro(/:promo)',
  sign_in: 'iniciar-sesion',
  sign_out: 'cerrar-sesion',
  confirmation: 'confirmacion',
  new: 'nuevo',
  edit: 'editar/perfil',
  cancel: 'cancelar'
}

model_override_paths = {
  new: 'nuevo',
  edit: 'editar',
  update: 'actualizar',
  delete: 'eliminar'
}

Rails.application.routes.draw do
  # Search module
  get 'buscar', to: 'search#search', as: :search

  # Sidekiq panel
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => 'ac0d0b1/sidekiq'

  # errors
  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unacceptable'
  get '/500', to: 'errors#internal_error'

  # Newsletter
  post 'suscribirse', to: 'home#create', as: :newsletter_create
  get 'desuscribirme/:email', to: 'home#destroy', as: :newsletter_destroy

  # Promos
  get 'promociones/gimnasios', to: 'coupons#gimnasios'
  get 'promociones/imanes', to: 'coupons#imanes'
  get 'registro-cupones(/:promo)', to: 'coupons#cupon_register', as: :coupon_register
  get 'mis-cupones', to: 'coupons#list', as: :coupon_list

  # Site routes
  root 'home#index'
  get 'cookies/:cookies', to: 'home#cookie', as: :cookie_consent
  get 'categorias/:id', to: 'categories#show', as: :category
  get 'marcas', to: 'brands#index', as: :brands
  get 'marcas/:id', to: 'brands#show', as: :brand
  get 'locales', to: 'branches#index', as: :branches
  get 'locales/:id', to: 'branches#show', as: :branch
  get 'p/:id', to: 'pages#show', as: :page
  get 'productos/:id/p/:p/v/:v', to: 'products#show', as: :product
  post 'carrito/agregar', to: 'shopping_cart#add_item', as: :shopping_cart_add_item
  post 'carrito/eliminar', to: 'shopping_cart#remove_item', as: :shopping_cart_remove_item
  delete 'carrito/borrar', to: 'shopping_cart#destroy_item', as: :shopping_cart_destroy_item
  delete 'carrito/vaciar', to: 'shopping_cart#clear', as: :shopping_cart_clear
  get 'carrito', to: 'shopping_cart#show', as: :shopping_cart_show
  get 'pedido/nuevo(/:cupon)', to: 'order#new', as: :order_new
  post 'pedido/crear', to: 'order#create', as: :order_create
  get 'pedido/resumen/:id', to: 'order#status', as: :order_status
  get 'pedido/catastrar-tarjeta/:id', to: 'order#payment', as: :order_payment
  post 'pedido/confirmar', to: 'order#confirm', as: :order_confirm
  post 'pedido/gracias/:id', to: 'order#greeting', as: :order_greeting
  get 'pedido/historico', to: 'order#history', as: :order_history
  get 'pedido/historico/:id', to: 'order#history_detail', as: :order_history_detail
  post 'pedido/repetir/:id', to: 'order#repeat_order', as: :order_repeat
  post 'contacto', to: 'home#contact', as: :send_contact_email
  get 'idioma/:lang', to: 'home#set_language', as: :set_language

  # Static pages
  get 'la-empresa', to: 'static#la_empresa', as: :empresa
  get 'historia', to: 'static#historia', as: :historia
  get 'quienes-somos', to: 'static#quienes_somos', as: :quienes_somos
  get 'contacto', to: 'home#contacto', as: :contacto
  get 'exportacion', to: 'static#export', as: :export
  get 'cobertura', to: 'static#cobertura', as: :cobertura

  # Payment transactions routes
  # Begin payment
  get 'checkout/pago', to: 'transactions#transaction_payment', as: :transaction_payment
  # Begin payment zimple
  get 'checkout/zimple', to: 'transactions#transaction_payment_zimple', as: :transaction_payment_zimple
  # Payment status
  get 'checkout/estado/:transaction_id/:process_id', to: 'transactions#transaction_status', as: :transaction_status
  # Cancel payment
  get 'checkout/cancelar/:transaction_id/:process_id', to: 'transactions#transaction_cancel', as: :transaction_cancel
  # Rollback payment
  get 'checkout/revertir/:transaction_id', to: 'transactions#transaction_rollback', as: :transaction_rollback
  # Get payment confirmation
  get 'checkout/confirmar/:transaction_id', to: 'transactions#transaction_origin_confirmation', as: :transaction_origin_confirmation
  # Confirm payment
  post 'checkout/confirmacion', to: 'transactions#transaction_confirm', as: :transaction_confirm

  #token
  get 'checkout/pago-tarjetas(/:order_id)', to: 'transactions#transaction_payment_token', as: :transaction_payment_token
  get 'checkout/agregar-nueva-tarjeta/:order', to: "transactions#transaction_payment_token_new_card", as: :transaction_payment_token_new_card
  get 'checkout/remove-credit-card/:ct', to: "transactions#transaction_payment_token_delete_card", as: :transaction_payment_token_delete_card
  post 'checkout/charge-token-payment', to: 'transactions#transaction_payment_token_charge', as: :transaction_payment_token_charge

  #Ajax
  post 'get-product-information', to: 'products#product_information', as: :get_product_information


  # Devise auth routes
  devise_for :users, path: 'usuarios', path_names: devise_override_paths, controllers: {
    omniauth_callbacks: 'omniauth',
    registrations: 'users/registrations'
  }

  namespace :panel do
    root 'home#index'
    get 'configuracion', to: 'settings#index', as: :settings
    patch 'configuracion', to: 'settings#update', as: :settings_update

    get 'pedidos-pendientes', to: 'orders#index_pending', as: :pending_orders
    get 'pedidos-enviados', to: 'orders#index_sent', as: :sent_orders
    get 'pedidos-incompletos-cancelados', to: 'orders#index_canceled', as: :canceled_orders
    get 'pedidos/ver/:id', to: 'orders#show', as: :order

    # Newsletter Panel.
    get 'newsletters', to: 'newsletters#index', as: :newsletters
    delete 'newsletter/remover/:id', to: 'newsletters#destroy', as: :newsletter_destroy

    # Delivery Schedule
    get 'horarios-delivery', to: 'delivery_schedules#edit', as: :delivery_schedules
    patch 'actualizar-horarios', to: 'delivery_schedules#update', as: :delivery_schedule_update

    # Countdown promotions
    get 'contador-tiempo-promocion', to: 'countdowns#edit', as: :countdown_edit
    match 'actualizar-contador-tiempo', to: 'countdowns#update', via: [:post, :patch], as: :countdown_update

    get 'update_discounts', to: "product_discounts#update_all"

    # Devise auth routes for panel
    devise_for :admins, path: 'administradores', path_names: devise_override_paths, controllers: {
      sessions: 'panel/admins/sessions',
      passwords: 'panel/admins/passwords',
      registrations: 'panel/admins/registrations'
    }

    devise_scope :admin do
      get 'administradores', to: 'admins#index', as: :admins
      get 'administradores/editar/:id', to: 'admins/registrations#edit', as: :admin_edit
      delete 'eliminar-administrador/:id', to: 'admins#destroy', as: :admin_delete
    end

    # Model routing
    resources :branches, path: 'sucursales', path_names: model_override_paths
    resources :varieties, path: 'variedades', path_names: model_override_paths
    resources :presentations, path: 'presentaciones', path_names: model_override_paths
    resources :subcategories, path: 'subcategorias', path_names: model_override_paths
    resources :categories, path: 'categorias', path_names: model_override_paths
    resources :pages, path: 'paginas', path_names: model_override_paths
    resources :representatives, path: 'representantes', path_names: model_override_paths
    resources :products, path: 'productos', path_names: model_override_paths
    resources :brands, path: 'marcas', path_names: model_override_paths
    resources :sliders, path: 'sliders', path_names: model_override_paths
    resources :amount_discounts, path: 'descuentos_importe', path_names: model_override_paths
    resources :product_discounts, path: 'descuentos_producto', path_names: model_override_paths
    resources :customers, path: 'clientes', path_names: model_override_paths

    get 'actualizar-precios', to: 'products#update_prices', as: :price_update
    get 'template_precios', to: 'products#prices_template', as: :prices_template, defaults: { format: :csv }
    post 'actualizar-precios', to: 'products#prices_upload', as: :prices_upload
  end
end
