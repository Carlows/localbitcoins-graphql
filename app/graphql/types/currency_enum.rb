Types::CurrencyEnum = GraphQL::EnumType.define do
  name "Currencies"
  description "Supported currencies"

  value("BTC", "Bitcoin")
  value("USD", "$")
end
