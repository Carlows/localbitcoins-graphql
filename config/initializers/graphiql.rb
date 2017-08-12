if Rails.env.development?
  GraphiQL::Rails.config.headers['Authorization'] = -> (context) do
    "Bearer #{ENV["GRAPHIQL_TOKEN"]}"
  end
end
