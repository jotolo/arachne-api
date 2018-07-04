Rails.application.routes.draw do
  resources :ftp_files do
    collection do
      get :search
    end
  end
  resources :ftp_servers
end
