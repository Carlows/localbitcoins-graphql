Rails.application.routes.draw do
  get 'signup_controller/create'

  post 'signup', to: 'signup#create'
  post 'login', to: 'user_token#create'
  post '/graphql', to: 'graphql#execute'

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
end
