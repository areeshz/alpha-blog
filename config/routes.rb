Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles
  # "resources :articles" provides REST-ful routes to Rails resources (including index, show, edit, create, new, update (post & patch), destroy)
end
