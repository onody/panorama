Rails.application.routes.draw do
  resources :trades do
    collection do
      get :chart, to: 'trades#chart'
    end
  end
  resources :vendors
end
