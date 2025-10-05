require "application_system_test_case"

class ProductDiscountsTest < ApplicationSystemTestCase
  setup do
    @product_discount = product_discounts(:one)
  end

  test "visiting the index" do
    visit product_discounts_url
    assert_selector "h1", text: "Product Discounts"
  end

  test "creating a Product discount" do
    visit product_discounts_url
    click_on "New Product Discount"

    fill_in "Begin date", with: @product_discount.begin_date
    fill_in "Discount rate", with: @product_discount.discount_rate
    fill_in "End date", with: @product_discount.end_date
    fill_in "Internal product", with: @product_discount.internal_product_id
    fill_in "Max quantity", with: @product_discount.max_quantity
    fill_in "Min quantity", with: @product_discount.min_quantity
    click_on "Create Product discount"

    assert_text "Product discount was successfully created"
    click_on "Back"
  end

  test "updating a Product discount" do
    visit product_discounts_url
    click_on "Edit", match: :first

    fill_in "Begin date", with: @product_discount.begin_date
    fill_in "Discount rate", with: @product_discount.discount_rate
    fill_in "End date", with: @product_discount.end_date
    fill_in "Internal product", with: @product_discount.internal_product_id
    fill_in "Max quantity", with: @product_discount.max_quantity
    fill_in "Min quantity", with: @product_discount.min_quantity
    click_on "Update Product discount"

    assert_text "Product discount was successfully updated"
    click_on "Back"
  end

  test "destroying a Product discount" do
    visit product_discounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product discount was successfully destroyed"
  end
end
