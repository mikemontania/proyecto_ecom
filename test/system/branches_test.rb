require "application_system_test_case"

class BranchesTest < ApplicationSystemTestCase
  setup do
    @branch = branches(:one)
  end

  test "visiting the index" do
    visit branches_url
    assert_selector "h1", text: "Branches"
  end

  test "creating a Branch" do
    visit branches_url
    click_on "New Branch"

    check "Active" if @branch.active
    fill_in "Address", with: @branch.address
    fill_in "Hours", with: @branch.hours
    fill_in "Image", with: @branch.image
    fill_in "Location", with: @branch.location
    fill_in "Name br", with: @branch.name_br
    fill_in "Name en", with: @branch.name_en
    fill_in "Name es", with: @branch.name_es
    fill_in "Phone", with: @branch.phone
    click_on "Create Branch"

    assert_text "Branch was successfully created"
    click_on "Back"
  end

  test "updating a Branch" do
    visit branches_url
    click_on "Edit", match: :first

    check "Active" if @branch.active
    fill_in "Address", with: @branch.address
    fill_in "Hours", with: @branch.hours
    fill_in "Image", with: @branch.image
    fill_in "Location", with: @branch.location
    fill_in "Name br", with: @branch.name_br
    fill_in "Name en", with: @branch.name_en
    fill_in "Name es", with: @branch.name_es
    fill_in "Phone", with: @branch.phone
    click_on "Update Branch"

    assert_text "Branch was successfully updated"
    click_on "Back"
  end

  test "destroying a Branch" do
    visit branches_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Branch was successfully destroyed"
  end
end
