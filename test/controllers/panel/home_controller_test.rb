require 'test_helper'

class Panel::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get panel_home_index_url
    assert_response :success
  end

end
