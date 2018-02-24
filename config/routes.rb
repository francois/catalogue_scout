Rails.application.routes.draw do
  root to: "home#show"

  get "sign-in",     to: "sessions#new",     as: :signin
  delete "sign-out", to: "sessions#destroy", as: :signout
end
