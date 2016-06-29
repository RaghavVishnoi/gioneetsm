require 'test_helper'

class UserParentsControllerTest < ActionController::TestCase
  setup do
    @user_parent = user_parents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_parents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_parent" do
    assert_difference('UserParent.count') do
      post :create, user_parent: {  }
    end

    assert_redirected_to user_parent_path(assigns(:user_parent))
  end

  test "should show user_parent" do
    get :show, id: @user_parent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_parent
    assert_response :success
  end

  test "should update user_parent" do
    patch :update, id: @user_parent, user_parent: {  }
    assert_redirected_to user_parent_path(assigns(:user_parent))
  end

  test "should destroy user_parent" do
    assert_difference('UserParent.count', -1) do
      delete :destroy, id: @user_parent
    end

    assert_redirected_to user_parents_path
  end
end
