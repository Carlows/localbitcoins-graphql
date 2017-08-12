module Mutations
  module PublicationMutations
    Create = GraphQL::Relay::Mutation.define do
      name 'CreatePublication'
      description 'Create a new Publication'

      input_field :title, !types.String
      input_field :description, !types.String
      input_field :amount, !types.Float
      input_field :currency, !Types::CurrencyEnum

      return_field :publication, Types::PublicationType

      resolve ->(obj, inputs, ctx) do
        current_user = ctx[:current_user]
        currency = inputs[:currency]
        amount = inputs[:amount]
        user_balance = current_user.send("account_balance_#{currency}")

        return GraphQL::ExecutionError.new('Not enough balance') if user_balance < amount

        publication = current_user.publications.create(inputs.to_h)

        { publication: publication }
      end
    end
  end
end
