require 'test_helper'

class Api::V1::UserSessionsControllerTest < ActionController::TestCase
  test "should get logout_user" do
    get :logout_user
    assert_response :success
  end

end
