require "test_helper"

class PlatformProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get platform_products_show_url
    assert_response :success
  end
end
