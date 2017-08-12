# An awesome readme

This is a sample app to test our stack for GraphQL.

After cloning the project run:

```
bundle install
rails server
```

You can use GraphiQL navigating to `localhost:3000/graphiql`, however you need to provide a JWT token to use it.

Use postman to create a user with this endpoint `POST http://localhost:3000/signup`, then add an environment variable to the .env file like this:

```
GRAPHIQL_TOKEN=YOUR_JWT
```
