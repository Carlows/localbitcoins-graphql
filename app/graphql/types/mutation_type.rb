Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"
  description "The root type for mutations"

  field :createPublication, field: Mutations::PublicationMutations::Create.field
  # field :updatePublication, field: Mutations::PublicationMutations::Update.field
  # field :deletePublication, field: Mutations::PublicationMutations::Delete.field
  field :rechargeCurrency, field: Mutations::UserMutations::RechargeCurrency.field
  field :buyCurrency, field: Mutations::UserMutations::BuyCurrency.field
end
