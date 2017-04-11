Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match 'chel', to: 'chel#new_match', via: [:post]
  match 'button', to: 'chel#button', via: [:post]

end
