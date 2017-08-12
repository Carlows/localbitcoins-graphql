Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :current_user do
    type Types::UserType
    description "The current authenticated user"

    resolve -> (obj, args, ctx) do
      ctx[:current_user]
    end
  end

  connection :users do
    type Types::UserType.connection_type
    description "All Users"

    resolve -> (obj, args, ctx) do
      User.all
    end
  end

  connection :publications do
    type Types::PublicationType.connection_type
    description "Publications"
    argument :active, types.Boolean, 'Filters publications by active'

    resolve -> (obj, args, ctx) do
      if args[:active].present?
        Publication.where(active: args[:active]).all
      else
        Publication.all
      end
    end
  end

  connection :transactions do
    type Types::TransactionType.connection_type
    description "Transactions"
  end
end

def connection_arguments
  argument :first, types.Int, "Returns the first n elements from the list"
  argument :last, types.Int, "Returns the last n elements from the list"
  argument :before, types.String, "Returns the elements in the list that come before the specified cursor"
  argument :after, types.String, "Returns the elements in the list that come after the specified cursor"
end
