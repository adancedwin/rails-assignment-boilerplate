# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :books
  get 'book/add_author' => 'books#add_author'
  get 'book/select_author' => 'books#select_author'

  root to: redirect('/books')
end
