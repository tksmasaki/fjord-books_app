Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    resources :books
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
