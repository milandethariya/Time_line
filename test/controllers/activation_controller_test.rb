require 'test_helper'

class ActivationControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get activation_new_url
    assert_response :success
  end

end
