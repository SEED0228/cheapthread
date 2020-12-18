require 'test_helper'

class Public::GachasControllerTest < ActionDispatch::IntegrationTest
  test "should get default" do
    get public_gachas_default_url
    assert_response :success
  end

  test "should get price" do
    get public_gachas_price_url
    assert_response :success
  end

  test "should get calorie" do
    get public_gachas_calorie_url
    assert_response :success
  end

end
