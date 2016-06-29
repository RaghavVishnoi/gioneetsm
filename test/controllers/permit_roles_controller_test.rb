require 'test_helper'

class PermitRolesControllerTest < ActionController::TestCase
  setup do
    @permit_role = permit_roles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:permit_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create permit_role" do
    assert_difference('PermitRole.count') do
      post :create, permit_role: { child_role: @permit_role.child_role, parent_role: @permit_role.parent_role }
    end

    assert_redirected_to permit_role_path(assigns(:permit_role))
  end

  test "should show permit_role" do
    get :show, id: @permit_role
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @permit_role
    assert_response :success
  end

  test "should update permit_role" do
    patch :update, id: @permit_role, permit_role: { child_role: @permit_role.child_role, parent_role: @permit_role.parent_role }
    assert_redirected_to permit_role_path(assigns(:permit_role))
  end

  test "should destroy permit_role" do
    assert_difference('PermitRole.count', -1) do
      delete :destroy, id: @permit_role
    end

    assert_redirected_to permit_roles_path
  end
end
