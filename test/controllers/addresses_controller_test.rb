require 'test_helper'

class AddressesControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @address = addresses(:one)
  end

  test "should get index" do
    get :index, params: { user_id: @user }
    assert_response :success
  end

  test "should get new" do
    get :new, params: { user_id: @user }
    assert_response :success
  end

  test "should create address" do
    assert_difference('Address.count') do
      post :create, params: { user_id: @user, address: @address.attributes }
    end

    assert_redirected_to user_address_path(@user, Address.last)
  end

  test "should show address" do
    get :show, params: { user_id: @user, id: @address }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { user_id: @user, id: @address }
    assert_response :success
  end

  test "should update address" do
    put :update, params: { user_id: @user, id: @address, address: @address.attributes }
    assert_redirected_to user_address_path(@user, Address.last)
  end

  test "should destroy address" do
    assert_difference('Address.count', -1) do
      delete :destroy, params: { user_id: @user, id: @address }
    end

    assert_redirected_to user_addresses_path(@user)
  end
end
