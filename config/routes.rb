Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "custom_registrations" }

  devise_scope :user do
    authenticated :user do
      root 'custom_registrations#edit', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
