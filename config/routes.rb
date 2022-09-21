Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :boards, :columns, :stories
      resources :boards, :only => [:show] do
        member do
          get :filter_by
        end
      end
    end
  end
end
