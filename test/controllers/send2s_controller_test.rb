require 'test_helper'

class Send2sControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get send2s_index_url
    assert_response :success
  end

  test "should get new" do
    get send2s_new_url
    assert_response :success
  end

  test "should get edit" do
    get send2s_edit_url
    assert_response :success
  end

  test "should get show" do
    get send2s_show_url
    assert_response :success
  end

end
