require 'test_helper'

class ReactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reaction = reactions(:one)
  end

  test "should get index" do
    get reactions_url
    assert_response :success
  end

  test "should get new" do
    get new_reaction_url
    assert_response :success
  end

  test "should create reaction" do
    assert_difference('Reaction.count') do
      post reactions_url, params: { reaction: { post_id: @reaction.post_id, reaction_type_id: @reaction.reaction_type_id, user_id: @reaction.user_id } }
    end

    assert_redirected_to reaction_url(Reaction.last)
  end

  test "should show reaction" do
    get reaction_url(@reaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_reaction_url(@reaction)
    assert_response :success
  end

  test "should update reaction" do
    patch reaction_url(@reaction), params: { reaction: { post_id: @reaction.post_id, reaction_type_id: @reaction.reaction_type_id, user_id: @reaction.user_id } }
    assert_redirected_to reaction_url(@reaction)
  end

  test "should destroy reaction" do
    assert_difference('Reaction.count', -1) do
      delete reaction_url(@reaction)
    end

    assert_redirected_to reactions_url
  end
end
