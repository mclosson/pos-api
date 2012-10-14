require 'test_helper'

class UnitSizesControllerTest < ActionController::TestCase
  setup do
    @unit_size = unit_sizes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:unit_sizes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unit_size" do
    assert_difference('UnitSize.count') do
      post :create, unit_size: { description: @unit_size.description, size: @unit_size.size }
    end

    assert_redirected_to unit_size_path(assigns(:unit_size))
  end

  test "should show unit_size" do
    get :show, id: @unit_size
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @unit_size
    assert_response :success
  end

  test "should update unit_size" do
    put :update, id: @unit_size, unit_size: { description: @unit_size.description, size: @unit_size.size }
    assert_redirected_to unit_size_path(assigns(:unit_size))
  end

  test "should destroy unit_size" do
    assert_difference('UnitSize.count', -1) do
      delete :destroy, id: @unit_size
    end

    assert_redirected_to unit_sizes_path
  end
end
