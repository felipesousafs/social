require "application_system_test_case"

class StrikesTest < ApplicationSystemTestCase
  setup do
    @strike = strikes(:one)
  end

  test "visiting the index" do
    visit strikes_url
    assert_selector "h1", text: "Strikes"
  end

  test "creating a Strike" do
    visit strikes_url
    click_on "New Strike"

    fill_in "Post", with: @strike.post_id
    fill_in "Text", with: @strike.text
    fill_in "User", with: @strike.user_id
    click_on "Create Strike"

    assert_text "Strike was successfully created"
    click_on "Back"
  end

  test "updating a Strike" do
    visit strikes_url
    click_on "Edit", match: :first

    fill_in "Post", with: @strike.post_id
    fill_in "Text", with: @strike.text
    fill_in "User", with: @strike.user_id
    click_on "Update Strike"

    assert_text "Strike was successfully updated"
    click_on "Back"
  end

  test "destroying a Strike" do
    visit strikes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Strike was successfully destroyed"
  end
end
