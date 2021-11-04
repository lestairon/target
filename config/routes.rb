Rails.application.routes.draw do
  devise_for :users, skip: :all

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'users', as: nil, to: 'users/registrations#create'
      end
    end
  end
end
