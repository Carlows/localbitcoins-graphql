class SignupController < ApplicationController
  def create
    user = User.new(signup_params)

    if user.save
      jwt_token = user.generate_auth_token
      render json: { jwt: jwt_token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def signup_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
