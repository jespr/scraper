Rails.application.routes.draw do
  get 'scrape/new'
  post 'scrape/create'

  root to: 'scrape#new'
end
