require "application_system_test_case"

class RepresentativesTest < ApplicationSystemTestCase
  setup do
    @representative = representatives(:one)
  end

  test "visiting the index" do
    visit representatives_url
    assert_selector "h1", text: "Representatives"
  end

  test "creating a Representative" do
    visit representatives_url
    click_on "New Representative"

    fill_in "Address", with: @representative.address
    fill_in "Email", with: @representative.email
    fill_in "Latitude", with: @representative.latitude
    fill_in "Longitude", with: @representative.longitude
    fill_in "Name", with: @representative.name
    fill_in "Phone", with: @representative.phone
    fill_in "Website", with: @representative.website
    click_on "Create Representative"

    assert_text "Representative was successfully created"
    click_on "Back"
  end

  test "updating a Representative" do
    visit representatives_url
    click_on "Edit", match: :first

    fill_in "Address", with: @representative.address
    fill_in "Email", with: @representative.email
    fill_in "Latitude", with: @representative.latitude
    fill_in "Longitude", with: @representative.longitude
    fill_in "Name", with: @representative.name
    fill_in "Phone", with: @representative.phone
    fill_in "Website", with: @representative.website
    click_on "Update Representative"

    assert_text "Representative was successfully updated"
    click_on "Back"
  end

  test "destroying a Representative" do
    visit representatives_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Representative was successfully destroyed"
  end
end
