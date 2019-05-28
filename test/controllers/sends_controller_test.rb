require 'test_helper'

class SendsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get sends_update_url
    assert_response :success
  end

end
