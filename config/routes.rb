Rails.application.routes.draw do


  # namespace :api, :defaults => {:format => :json} do
  #   namespace :v1 do
  #     resources :group_events
  #   end
  # end

  scope '/api', :defaults => {:format => :html} do
    scope '/v1' do
      scope '/group_events' do
        get '/' => 'group_events#index', as: 'group_events'
        post '/' => 'group_events#create'
        get '/new' => 'group_events#new', as: 'new_group_event'
        scope '/:id' do
          get '/' => 'group_events#show', as: 'group_event'
          put '/' => 'group_events#update', as: 'edit_group_event'
          put '/publish' => 'group_events#publish', as: 'publish_group_event'
          delete '/' => 'group_events#delete'
        end
      end
    end
  end

end
