require 'test_helper'

class StaticControllerTest < ActionDispatch::IntegrationTest
  test "should get la_empresa" do
    get static_la_empresa_url
    assert_response :success
  end

  test "should get historia" do
    get static_historia_url
    assert_response :success
  end

  test "should get quienes_somos" do
    get static_quienes_somos_url
    assert_response :success
  end

  test "should get contacto" do
    get static_contacto_url
    assert_response :success
  end

  test "should get export" do
    get static_export_url
    assert_response :success
  end

end
