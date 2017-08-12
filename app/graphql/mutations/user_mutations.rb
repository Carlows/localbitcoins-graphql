module Mutations
  module UserMutations
    RechargeCurrency = GraphQL::Relay::Mutation.define do
      name 'RechargeCurrency'
      description 'Credits more currency to the current user'

      input_field :amount, !types.Float
      input_field :currency, !Types::CurrencyEnum

      return_field :user, Types::UserType
      return_field :transaction, Types::TransactionType

      resolve ->(obj, inputs, ctx) do
        current_user = ctx[:current_user]
        currency = inputs[:currency]
        amount = inputs[:amount]

        transaction = current_user.transactions.create(transaction_type: 'credit', currency: currency, amount: amount)

        { user: current_user, transaction: transaction }
      end
    end

    BuyCurrency = GraphQL::Relay::Mutation.define do
      name 'BuyCurrency'
      description 'Buys from a publication'

      input_field :publication_id, !types.String, "The id of the publication to buy from"
      input_field :currency, !Types::CurrencyEnum, "The currency to use for payments"

      return_field :user, Types::UserType
      return_field :publication, Types::PublicationType

      resolve ->(obj, inputs, ctx) do
        current_user = ctx[:current_user]
        currency = inputs[:currency]
        _, publication_id = GraphQL::Schema::UniqueWithinType.decode(inputs[:publication_id], separator: '---')
        user_balance = current_user.send("account_balance_#{currency}")
        publication = Publication.find(publication_id)

        return GraphQL::ExecutionError.new('Not enough balance') if user_balance < publication.amount
        return GraphQL::ExecutionError.new('You cannot buy on unactive publications') unless publication.active

        ApplicationRecord.transaction do
          current_user.transactions.create!(transaction_type: 'debit', currency: currency, amount: publication.amount)
          current_user.transactions.create!(transaction_type: 'credit', currency: publication.currency, amount: publication.amount)

          publication.user.transactions.create!(transaction_type: 'credit', currency: currency, amount: publication.amount)
          publication.user.transactions.create!(transaction_type: 'debit', currency: publication.currency, amount: publication.amount)

          publication.update_attributes!(active: false)

          {
            user: current_user,
            publication: publication
          }
        end
      end
    end
  end
end
