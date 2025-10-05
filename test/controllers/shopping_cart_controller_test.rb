require 'test_helper'

class ShoppingCartControllerTest < ActionDispatch::IntegrationTest
  test "should get add_item" do
    get shopping_cart_add_item_url
    assert_response :success
  end

  test "should get remove_item" do
    get shopping_cart_remove_item_url
    assert_response :success
  end

  test "should get gross_total_amount" do
    get shopping_cart_gross_total_amount_url
    assert_response :success
  end

  test "should get discount_rate" do
    get shopping_cart_discount_rate_url
    assert_response :success
  end

  test "should get discount_total" do
    get shopping_cart_discount_total_url
    assert_response :success
  end

  test "should get net_total_amount" do
    get shopping_cart_net_total_amount_url
    assert_response :success
  end

  test "should get shopping_cart_factory" do
    get shopping_cart_shopping_cart_factory_url
    assert_response :success
  end

end
