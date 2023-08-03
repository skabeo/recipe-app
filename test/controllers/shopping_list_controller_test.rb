require "test_helper"

class ShoppingListControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shopping_list_index_url
    assert_response :success
  end
end
