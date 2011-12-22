::Refinery::Application.routes.draw do
  resources :products

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :products do
      collection do
        put  :update_prices
        post :update_positions
      end
    end
  end
end
