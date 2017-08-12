LocalbitcoinsGraphqlSchema = GraphQL::Schema.define do
  max_depth 10
  mutation(Types::MutationType)
  query(Types::QueryType)

  resolve_type -> (_type, object, _ctx) { LocalbitcoinsGraphqlSchema.types[object.class.name] }

  # These are used by relay
  object_from_id -> (id, ctx) { decode_object(id, ctx) }
  id_from_object -> (obj, type, ctx) { encode_object(obj, type, ctx) }

  rescue_from ActiveRecord::RecordInvalid, &:message
  rescue_from ActiveRecord::Rollback, &:message
  rescue_from StandardError, &:message
  rescue_from ActiveRecord::RecordNotUnique, &:message
  rescue_from ActiveRecord::RecordNotFound, &:message

  def encode_object(object, type, _ctx)
    GraphQL::Schema::UniqueWithinType.encode(type.name, object.id, separator: '---')
  end

  def decode_object(id, ctx)
    type_name, record_id = GraphQL::Schema::UniqueWithinType.decode(id, separator: '---')

    # This `find` gives the user unrestricted access to *all* the records in the app.
    record = type_name.constantize.find(record_id)

    record
  end
end
