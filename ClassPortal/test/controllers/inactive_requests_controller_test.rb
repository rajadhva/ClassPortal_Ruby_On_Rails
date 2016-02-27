require 'test_helper'

class InactiveRequestsControllerTest < ActionController::TestCase
  setup do
    @inactive_request = inactive_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inactive_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inactive_request" do
    assert_difference('InactiveRequest.count') do
      post :create, inactive_request: {  }
    end

    assert_redirected_to inactive_request_path(assigns(:inactive_request))
  end

  test "should show inactive_request" do
    get :show, id: @inactive_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inactive_request
    assert_response :success
  end

  test "should update inactive_request" do
    patch :update, id: @inactive_request, inactive_request: {  }
    assert_redirected_to inactive_request_path(assigns(:inactive_request))
  end

  test "should destroy inactive_request" do
    assert_difference('InactiveRequest.count', -1) do
      delete :destroy, id: @inactive_request
    end

    assert_redirected_to inactive_requests_path
  end
end
