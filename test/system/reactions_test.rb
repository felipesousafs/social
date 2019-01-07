require "application_system_test_case"

class ReactionsTest < ApplicationSystemTestCase
  setup do
    @reaction = reactions(:one)
  end

  test "visiting the index" do
    visit reactions_url
    assert_selector "h1", text: "Reactions"
  end

  test "creating a Reaction" do
    visit reactions_url
    click_on "New Reaction"

    fill_in "Post", with: @reaction.post_id
    fill_in "Reaction type", with: @reaction.reaction_type_id
    fill_in "User", with: @reaction.user_id
    click_on "Create Reaction"

    assert_text "Reaction was successfully created"
    click_on "Back"
  end

  test "updating a Reaction" do
    visit reactions_url
    click_on "Edit", match: :first

    fill_in "Post", with: @reaction.post_id
    fill_in "Reaction type", with: @reaction.reaction_type_id
    fill_in "User", with: @reaction.user_id
    click_on "Update Reaction"

    assert_text "Reaction was successfully updated"
    click_on "Back"
  end

  test "destroying a Reaction" do
    visit reactions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reaction was successfully destroyed"
  end
end
