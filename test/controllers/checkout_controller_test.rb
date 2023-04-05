require "test_helper"

class CheckoutControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get checkout_show_url
    assert_response :success
  end
end
