Rails.application.routes.draw do

  root 'dashboard#index'
  get '/projects' => 'projects#index'

end
