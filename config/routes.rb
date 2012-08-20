Posapi::Application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      # Session Management
      # post "user/:location_id/session" => 'User#login'  # login /user/{location_id}/session
      # delete "user/:location_id/session/:token" => 'User#logout' # logoff /user/{location_id}/session/{token}
      post 'sessions' => 'Session#create'
      delete 'sessions/:id' => 'Session#destroy'

      # Time Keeping
      # post "user/:location_id/clock/:token" => 'Clock#in' #clock in POST /user/{location_id}/clock/{token}
      # delete "user/:location_id/clock/:token" => 'Clock@out' #clock out DEL /user/{location_id}/clock/{token}      

      # Sales
      post 'tickets' => 'Ticket#create' # create ticket POST /ticket/{location_id}/ returns: ticket_id
      # get "sku/:location_id/:sku": 'Sku#details' # get SKU Details GET /SKU/{location_id}/{SKU}
      # sku lookup
      # get "sku/:location_id/:sku" # SKU lookup GET /SKU/{location_id}/{SKU}
      # put "sku/:location_id/:sku" # deduct inventory PUT /SKU/{location_id}/{SKU}
      # post "ticket/:ticket_id/:location_id/:sku": 'Ticket#add_line_item' # add line item POST /ticket/{ticket_id}/{location_id}/{SKU}
      # delete "ticket/:ticket_id/:location_id/:sku" # remove line item DEL /ticket/{ticket_id}/{location_id}/{SKU}
      # delete "ticket/:ticket_id/:location_id" # void ticket DEL /ticket/{ticket_id}/{location_id}/
      # get "ticket/:ticket_id/:location_id" # get ticket details GET /ticket/{ticket_id}/{location_id}/
      # get "ticket/:ticket_id/:location_id/print" # print receipt GET /ticket/{ticket_id}/{location_id}/print
      # post "ticket/:ticket_id/:location_id/payment/:n/:payment_type/:amount" # collect payments POST /ticket/{ticket_id}/{location_id}/payment/{n}/{payment_type}/{amount}
      # post "ticket/:ticket_id/:location_id/exchange/sku/:sku/new_sku/:new_sku" # exchanges POST /ticket/{ticket_id}/{location_id}/exchange/SKU/{SKU}/new_SKU/{SKU}
      # post "ticket/:ticket_id/:location_id/return/sku/:sku" # returns POST /ticket/{ticket_id}/{location_id}/return/SKU/{SKU}

      # lock pos
      # put "pos/:location_id/session/:token/lock" # lock pos PUT /pos/{location_id}/session/{token}/lock

      # tally up sales
      # get "sales/:location_id" # get sales GET /sales/{location_id}/
      # get "sales/:location_id/:date" # /sales/{location_id}/{date}
      # get "sales" # /sales/
      # get "sales/:gender" # /sales/{gender}
      # get "sales/:supplier" # /sales/{supplier}
      # get "sales/:model" # /sales/{model}

      # cash reconsiliation
      # get "pos/:location_id/cash" # cash GET /pos/{location_id}/cash

      # perform inventory
      # get "sku/:location_id/:sku" # scan SKU GET /SKU/{location_id}/{SKU}
      # get "sku/:location_id/:sku/count" # SKU qty GET /SKU/{location_id}/{SKU}/count
      # get "sku/:location_id/compare" # compare GET /SKU/{location_id}/compare input:

    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
