require "application_system_test_case"

class YearsTest < ApplicationSystemTestCase
  setup do
    @year = years(:one)
  end

  test "visiting the index" do
    visit years_url
    assert_selector "h1", text: "Years"
  end

  test "should create year" do
    visit years_url
    click_on "New year"

    fill_in "Number", with: @year.number
    click_on "Create Year"

    assert_text "Year was successfully created"
    click_on "Back"
  end

  test "should update Year" do
    visit year_url(@year)
    click_on "Edit this year", match: :first

    fill_in "Number", with: @year.number
    click_on "Update Year"

    assert_text "Year was successfully updated"
    click_on "Back"
  end

  test "should destroy Year" do
    visit year_url(@year)
    click_on "Destroy this year", match: :first

    assert_text "Year was successfully destroyed"
  end
end
