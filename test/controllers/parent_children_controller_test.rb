require 'test_helper'

class ParentChildrenControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parent_child = parent_children(:one)
  end

  test "should get index" do
    get parent_children_url
    assert_response :success
  end

  test "should get new" do
    get new_parent_child_url
    assert_response :success
  end

  test "should create parent_child" do
    assert_difference('ParentChild.count') do
      post parent_children_url, params: { parent_child: { child_id: @parent_child.child_id, parent_id: @parent_child.parent_id } }
    end

    assert_redirected_to parent_child_url(ParentChild.last)
  end

  test "should show parent_child" do
    get parent_child_url(@parent_child)
    assert_response :success
  end

  test "should get edit" do
    get edit_parent_child_url(@parent_child)
    assert_response :success
  end

  test "should update parent_child" do
    patch parent_child_url(@parent_child), params: { parent_child: { child_id: @parent_child.child_id, parent_id: @parent_child.parent_id } }
    assert_redirected_to parent_child_url(@parent_child)
  end

  test "should destroy parent_child" do
    assert_difference('ParentChild.count', -1) do
      delete parent_child_url(@parent_child)
    end

    assert_redirected_to parent_children_url
  end
end
