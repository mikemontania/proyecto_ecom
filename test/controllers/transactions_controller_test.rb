require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get transaction_payment" do
    get transactions_transaction_payment_url
    assert_response :success
  end

  test "should get transaction_confirm" do
    get transactions_transaction_confirm_url
    assert_response :success
  end

  test "should get transaction_status" do
    get transactions_transaction_status_url
    assert_response :success
  end

  test "should get transaction_cancel" do
    get transactions_transaction_cancel_url
    assert_response :success
  end

  test "should get transaction_rollback" do
    get transactions_transaction_rollback_url
    assert_response :success
  end

end
