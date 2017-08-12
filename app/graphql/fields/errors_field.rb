Fields::ErrorsField = GraphQL::Field.define do
  name "Errors"
  description "Reasons the object couldn't be created or updated"
  type types[types.String]

  resolve ->(obj, args, ctx) do
    obj.errors.full_messages
  end
end
