require 'test_helper'

class BasesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bases_index_url
    assert_response :success
  end

  test "should get new" do
    get bases_new_url
    assert_response :success
  end

  test "should get edit" do
    get bases_edit_url
    assert_response :success
  end

end
