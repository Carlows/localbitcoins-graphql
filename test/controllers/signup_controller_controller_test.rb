require 'test_helper'

class SignupControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get signup_controller_create_url
    assert_response :success
  end

end
