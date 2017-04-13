require 'test_helper'

class ChowbusControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get admin" do
    get :admin
    assert_response :success
  end

  test "should get allmeal" do
    get :allmeal
    assert_response :success
  end

  test "should get restaurant" do
    get :restaurant
    assert_response :success
  end

end
