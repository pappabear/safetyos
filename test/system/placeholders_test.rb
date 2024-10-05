require "application_system_test_case"

class PlaceholdersTest < ApplicationSystemTestCase
  setup do
    @placeholder = placeholders(:one)
  end

  test "visiting the index" do
    visit placeholders_url
    assert_selector "h1", text: "Placeholders"
  end

  test "should create placeholder" do
    visit placeholders_url
    click_on "New placeholder"

    fill_in "Account", with: @placeholder.account_id
    fill_in "Name", with: @placeholder.name
    fill_in "Step", with: @placeholder.step_id
    click_on "Create Placeholder"

    assert_text "Placeholder was successfully created"
    click_on "Back"
  end

  test "should update Placeholder" do
    visit placeholder_url(@placeholder)
    click_on "Edit this placeholder", match: :first

    fill_in "Account", with: @placeholder.account_id
    fill_in "Name", with: @placeholder.name
    fill_in "Step", with: @placeholder.step_id
    click_on "Update Placeholder"

    assert_text "Placeholder was successfully updated"
    click_on "Back"
  end

  test "should destroy Placeholder" do
    visit placeholder_url(@placeholder)
    click_on "Destroy this placeholder", match: :first

    assert_text "Placeholder was successfully destroyed"
  end
end
