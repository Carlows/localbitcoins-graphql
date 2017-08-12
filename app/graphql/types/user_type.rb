Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'User Model'
  implements GraphQL::Relay::Node.interface

  global_id_field :id
  field :email, !types.String, 'Email of the User'
  field :first_name, !types.String, 'First name'
  field :last_name, !types.String, 'Last name'
  field :account_balance_BTC, !types.Float, 'Account Balance BTC'
  field :account_balance_USD, !types.Float, 'Account Balance USD'

  connection :transactions, Types::TransactionType.connection_type
  connection :publications, Types::PublicationType.connection_type

  field :errors, Fields::ErrorsField
end
