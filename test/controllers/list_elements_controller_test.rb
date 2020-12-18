require 'test_helper'

class ListElementsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get list_elements_new_url
    assert_response :success
  end

end
