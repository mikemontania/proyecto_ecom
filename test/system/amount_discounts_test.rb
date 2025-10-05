require "application_system_test_case"

class AmountDiscountsTest < ApplicationSystemTestCase
  setup do
    @amount_discount = amount_discounts(:one)
  end

  test "visiting the index" do
    visit amount_discounts_url
    assert_selector "h1", text: "Amount Discounts"
  end

  test "creating a Amount discount" do
    visit amount_discounts_url
    click_on "New Amount Discount"

    fill_in "Begin date", with: @amount_discount.begin_date
    fill_in "Discount rate", with: @amount_discount.discount_rate
    fill_in "End date", with: @amount_discount.end_date
    fill_in "Max amount", with: @amount_discount.max_amount
    fill_in "Min amount", with: @amount_discount.min_amount
    click_on "Create Amount discount"

    assert_text "Amount discount was successfully created"
    click_on "Back"
  end

  test "updating a Amount discount" do
    visit amount_discounts_url
    click_on "Edit", match: :first

    fill_in "Begin date", with: @amount_discount.begin_date
    fill_in "Discount rate", with: @amount_discount.discount_rate
    fill_in "End date", with: @amount_discount.end_date
    fill_in "Max amount", with: @amount_discount.max_amount
    fill_in "Min amount", with: @amount_discount.min_amount
    click_on "Update Amount discount"

    assert_text "Amount discount was successfully updated"
    click_on "Back"
  end

  test "destroying a Amount discount" do
    visit amount_discounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Amount discount was successfully destroyed"
  end
end
