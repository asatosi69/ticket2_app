require 'test_helper'

class ConnectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get connections_index_url
    assert_response :success
  end

  test "should get update" do
    get connections_update_url
    assert_response :success
  end

  test "should get edit" do
    get connections_edit_url
    assert_response :success
  end

end
