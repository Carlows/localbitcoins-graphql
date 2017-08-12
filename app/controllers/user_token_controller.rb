class UserTokenController < Knock::AuthTokenController
  def entity_class
    User
  end
end
