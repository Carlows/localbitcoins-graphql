Types::PublicationType = GraphQL::ObjectType.define do
  name 'Publication'
  description 'Publication Model'
  implements GraphQL::Relay::Node.interface

  global_id_field :id
  field :title, !types.String, 'Title'
  field :description, !types.String, 'Description'
  field :amount, !types.Float, 'Amount'
  field :currency, !types.String, 'Currency'
  field :active, !types.Boolean, 'Is this publication still active?'
  field :user, Types::UserType, 'User this publication belongs to'
  field :errors, Fields::ErrorsField
end
