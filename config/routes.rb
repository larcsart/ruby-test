Rails.application.routes.draw do
  get 'home/index'

  scope :admin do
    resources :offers, controller: 'admin/offers'
    post 'offers/:id/enable', to: 'admin/offers#enable', as: :enable_offer
    post 'offers/:id/disable', to: 'admin/offers#disable', as: :disable_offer
  end

  get 'admin', to: redirect('admin/offers/new')

  root 'home#index'
end
