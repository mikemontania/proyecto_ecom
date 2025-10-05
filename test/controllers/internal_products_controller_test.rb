require 'test_helper'

class InternalProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @internal_product = internal_products(:one)
  end

  test "should get index" do
    get internal_products_url
    assert_response :success
  end

  test "should get new" do
    get new_internal_product_url
    assert_response :success
  end

  test "should create internal_product" do
    assert_difference('InternalProduct.count') do
      post internal_products_url, params: { internal_product: { active: @internal_product.active, featured: @internal_product.featured, image: @internal_product.image, internal_code: @internal_product.internal_code, main: @internal_product.main, presentation_id: @internal_product.presentation_id, price: @internal_product.price, product_id: @internal_product.product_id, variety_id: @internal_product.variety_id } }
    end

    assert_redirected_to internal_product_url(InternalProduct.last)
  end

  test "should show internal_product" do
    get internal_product_url(@internal_product)
    assert_response :success
  end

  test "should get edit" do
    get edit_internal_product_url(@internal_product)
    assert_response :success
  end

  test "should update internal_product" do
    patch internal_product_url(@internal_product), params: { internal_product: { active: @internal_product.active, featured: @internal_product.featured, image: @internal_product.image, internal_code: @internal_product.internal_code, main: @internal_product.main, presentation_id: @internal_product.presentation_id, price: @internal_product.price, product_id: @internal_product.product_id, variety_id: @internal_product.variety_id } }
    assert_redirected_to internal_product_url(@internal_product)
  end

  test "should destroy internal_product" do
    assert_difference('InternalProduct.count', -1) do
      delete internal_product_url(@internal_product)
    end

    assert_redirected_to internal_products_url
  end
end
