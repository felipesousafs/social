require 'test_helper'

class StrikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @strike = strikes(:one)
  end

  test "should get index" do
    get strikes_url
    assert_response :success
  end

  test "should get new" do
    get new_strike_url
    assert_response :success
  end

  test "should create strike" do
    assert_difference('Strike.count') do
      post strikes_url, params: { strike: { post_id: @strike.post_id, text: @strike.text, user_id: @strike.user_id } }
    end

    assert_redirected_to strike_url(Strike.last)
  end

  test "should show strike" do
    get strike_url(@strike)
    assert_response :success
  end

  test "should get edit" do
    get edit_strike_url(@strike)
    assert_response :success
  end

  test "should update strike" do
    patch strike_url(@strike), params: { strike: { post_id: @strike.post_id, text: @strike.text, user_id: @strike.user_id } }
    assert_redirected_to strike_url(@strike)
  end

  test "should destroy strike" do
    assert_difference('Strike.count', -1) do
      delete strike_url(@strike)
    end

    assert_redirected_to strikes_url
  end
end
