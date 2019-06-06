require 'test_helper'

class ParentViewControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get parent_view_index_url
    assert_response :success
  end

end
