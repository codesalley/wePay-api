Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



  namespace 'api' do
    post '/signup', to: 'users#signup'
    post '/signin', to: 'users#signin'
    post '/me',  to: 'users#me'
  end

  root 'wepay#index'
end
