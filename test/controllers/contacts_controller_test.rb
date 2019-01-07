require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @contact = contacts(:one)
  end

  test "should get index" do
    get :index, params: { user_id: @user }
    assert_response :success
  end

  test "should get new" do
    get :new, params: { user_id: @user }
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post :create, params: { user_id: @user, contact: @contact.attributes }
    end

    assert_redirected_to user_contact_path(@user, Contact.last)
  end

  test "should show contact" do
    get :show, params: { user_id: @user, id: @contact }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { user_id: @user, id: @contact }
    assert_response :success
  end

  test "should update contact" do
    put :update, params: { user_id: @user, id: @contact, contact: @contact.attributes }
    assert_redirected_to user_contact_path(@user, Contact.last)
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete :destroy, params: { user_id: @user, id: @contact }
    end

    assert_redirected_to user_contacts_path(@user)
  end
end
