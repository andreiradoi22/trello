Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :boards do
        resources :columns do
          resources :stories
        end
      end
    end
  end
end
