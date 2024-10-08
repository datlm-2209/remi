Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  devise_for :users, path: "", path_names: {
    sign_in: "login",
    sign_out: "logout",
    registration: "register"
  },
  controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  resources :videos
end
