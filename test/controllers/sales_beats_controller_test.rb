require 'test_helper'

class SalesBeatsControllerTest < ActionController::TestCase
  setup do
    @sales_beat = sales_beats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sales_beats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sales_beat" do
    assert_difference('SalesBeat.count') do
      post :create, sales_beat: {  }
    end

    assert_redirected_to sales_beat_path(assigns(:sales_beat))
  end

  test "should show sales_beat" do
    get :show, id: @sales_beat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sales_beat
    assert_response :success
  end

  test "should update sales_beat" do
    patch :update, id: @sales_beat, sales_beat: {  }
    assert_redirected_to sales_beat_path(assigns(:sales_beat))
  end

  test "should destroy sales_beat" do
    assert_difference('SalesBeat.count', -1) do
      delete :destroy, id: @sales_beat
    end

    assert_redirected_to sales_beats_path
  end
end
