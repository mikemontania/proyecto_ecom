require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "creating a Product" do
    visit products_url
    click_on "New Product"

    check "Active" if @product.active
    fill_in "Category", with: @product.category_id
    fill_in "Description br", with: @product.description_br
    fill_in "Description en", with: @product.description_en
    fill_in "Description es", with: @product.description_es
    check "Featured" if @product.featured
    fill_in "Name br", with: @product.name_br
    fill_in "Name en", with: @product.name_en
    fill_in "Name es", with: @product.name_es
    fill_in "Subcategory", with: @product.subcategory_id
    fill_in "Uses br", with: @product.uses_br
    fill_in "Uses en", with: @product.uses_en
    fill_in "Uses es", with: @product.uses_es
    click_on "Create Product"

    assert_text "Product was successfully created"
    click_on "Back"
  end

  test "updating a Product" do
    visit products_url
    click_on "Edit", match: :first

    check "Active" if @product.active
    fill_in "Category", with: @product.category_id
    fill_in "Description br", with: @product.description_br
    fill_in "Description en", with: @product.description_en
    fill_in "Description es", with: @product.description_es
    check "Featured" if @product.featured
    fill_in "Name br", with: @product.name_br
    fill_in "Name en", with: @product.name_en
    fill_in "Name es", with: @product.name_es
    fill_in "Subcategory", with: @product.subcategory_id
    fill_in "Uses br", with: @product.uses_br
    fill_in "Uses en", with: @product.uses_en
    fill_in "Uses es", with: @product.uses_es
    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "destroying a Product" do
    visit products_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product was successfully destroyed"
  end
end
