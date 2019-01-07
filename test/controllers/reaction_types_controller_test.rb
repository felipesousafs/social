require 'test_helper'

class ReactionTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reaction_type = reaction_types(:one)
  end

  test "should get index" do
    get reaction_types_url
    assert_response :success
  end

  test "should get new" do
    get new_reaction_type_url
    assert_response :success
  end

  test "should create reaction_type" do
    assert_difference('ReactionType.count') do
      post reaction_types_url, params: { reaction_type: { description: @reaction_type.description, name: @reaction_type.name } }
    end

    assert_redirected_to reaction_type_url(ReactionType.last)
  end

  test "should show reaction_type" do
    get reaction_type_url(@reaction_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_reaction_type_url(@reaction_type)
    assert_response :success
  end

  test "should update reaction_type" do
    patch reaction_type_url(@reaction_type), params: { reaction_type: { description: @reaction_type.description, name: @reaction_type.name } }
    assert_redirected_to reaction_type_url(@reaction_type)
  end

  test "should destroy reaction_type" do
    assert_difference('ReactionType.count', -1) do
      delete reaction_type_url(@reaction_type)
    end

    assert_redirected_to reaction_types_url
  end
end
