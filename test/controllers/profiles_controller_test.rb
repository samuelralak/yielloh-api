require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  setup do
    @profile = profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profiles)
  end

  test "should create profile" do
    assert_difference('Profile.count') do
      post :create, profile: { about: @profile.about, fullname: @profile.fullname, location: @profile.location, user_id: @profile.user_id, username: @profile.username }
    end

    assert_response 201
  end

  test "should show profile" do
    get :show, id: @profile
    assert_response :success
  end

  test "should update profile" do
    put :update, id: @profile, profile: { about: @profile.about, fullname: @profile.fullname, location: @profile.location, user_id: @profile.user_id, username: @profile.username }
    assert_response 204
  end

  test "should destroy profile" do
    assert_difference('Profile.count', -1) do
      delete :destroy, id: @profile
    end

    assert_response 204
  end
end
