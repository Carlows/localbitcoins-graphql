Types::TransactionType = GraphQL::ObjectType.define do
  name 'Transaction'
  description 'Transaction Model'
  implements GraphQL::Relay::Node.interface

  global_id_field :id
  field :transaction_type, !types.String, 'Type of the transaction'
  field :currency, !types.String, 'Currency type of the transaction'
  field :amount, !types.Float, 'Amount'
  field :user, Types::UserType, 'User this transaction belongs to'
  field :errors, Fields::ErrorsField
end
