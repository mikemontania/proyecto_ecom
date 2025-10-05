require 'test_helper'

class AmountDiscountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @amount_discount = amount_discounts(:one)
  end

  test "should get index" do
    get amount_discounts_url
    assert_response :success
  end

  test "should get new" do
    get new_amount_discount_url
    assert_response :success
  end

  test "should create amount_discount" do
    assert_difference('AmountDiscount.count') do
      post amount_discounts_url, params: { amount_discount: { begin_date: @amount_discount.begin_date, discount_rate: @amount_discount.discount_rate, end_date: @amount_discount.end_date, max_amount: @amount_discount.max_amount, min_amount: @amount_discount.min_amount } }
    end

    assert_redirected_to amount_discount_url(AmountDiscount.last)
  end

  test "should show amount_discount" do
    get amount_discount_url(@amount_discount)
    assert_response :success
  end

  test "should get edit" do
    get edit_amount_discount_url(@amount_discount)
    assert_response :success
  end

  test "should update amount_discount" do
    patch amount_discount_url(@amount_discount), params: { amount_discount: { begin_date: @amount_discount.begin_date, discount_rate: @amount_discount.discount_rate, end_date: @amount_discount.end_date, max_amount: @amount_discount.max_amount, min_amount: @amount_discount.min_amount } }
    assert_redirected_to amount_discount_url(@amount_discount)
  end

  test "should destroy amount_discount" do
    assert_difference('AmountDiscount.count', -1) do
      delete amount_discount_url(@amount_discount)
    end

    assert_redirected_to amount_discounts_url
  end
end
