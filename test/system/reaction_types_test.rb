require "application_system_test_case"

class ReactionTypesTest < ApplicationSystemTestCase
  setup do
    @reaction_type = reaction_types(:one)
  end

  test "visiting the index" do
    visit reaction_types_url
    assert_selector "h1", text: "Reaction Types"
  end

  test "creating a Reaction type" do
    visit reaction_types_url
    click_on "New Reaction Type"

    fill_in "Description", with: @reaction_type.description
    fill_in "Name", with: @reaction_type.name
    click_on "Create Reaction type"

    assert_text "Reaction type was successfully created"
    click_on "Back"
  end

  test "updating a Reaction type" do
    visit reaction_types_url
    click_on "Edit", match: :first

    fill_in "Description", with: @reaction_type.description
    fill_in "Name", with: @reaction_type.name
    click_on "Update Reaction type"

    assert_text "Reaction type was successfully updated"
    click_on "Back"
  end

  test "destroying a Reaction type" do
    visit reaction_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reaction type was successfully destroyed"
  end
end
