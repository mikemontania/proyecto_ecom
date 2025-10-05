require "application_system_test_case"

class InternalProductsTest < ApplicationSystemTestCase
  setup do
    @internal_product = internal_products(:one)
  end

  test "visiting the index" do
    visit internal_products_url
    assert_selector "h1", text: "Internal Products"
  end

  test "creating a Internal product" do
    visit internal_products_url
    click_on "New Internal Product"

    check "Active" if @internal_product.active
    check "Featured" if @internal_product.featured
    fill_in "Image", with: @internal_product.image
    fill_in "Internal code", with: @internal_product.internal_code
    check "Main" if @internal_product.main
    fill_in "Presentation", with: @internal_product.presentation_id
    fill_in "Price", with: @internal_product.price
    fill_in "Product", with: @internal_product.product_id
    fill_in "Variety", with: @internal_product.variety_id
    click_on "Create Internal product"

    assert_text "Internal product was successfully created"
    click_on "Back"
  end

  test "updating a Internal product" do
    visit internal_products_url
    click_on "Edit", match: :first

    check "Active" if @internal_product.active
    check "Featured" if @internal_product.featured
    fill_in "Image", with: @internal_product.image
    fill_in "Internal code", with: @internal_product.internal_code
    check "Main" if @internal_product.main
    fill_in "Presentation", with: @internal_product.presentation_id
    fill_in "Price", with: @internal_product.price
    fill_in "Product", with: @internal_product.product_id
    fill_in "Variety", with: @internal_product.variety_id
    click_on "Update Internal product"

    assert_text "Internal product was successfully updated"
    click_on "Back"
  end

  test "destroying a Internal product" do
    visit internal_products_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Internal product was successfully destroyed"
  end
end
