require 'test_helper'

class OmniauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  test "should get instedd" do
    get omniauth_callbacks_instedd_url
    assert_response :success
  end

  test "should get generic" do
    get omniauth_callbacks_generic_url
    assert_response :success
  end

end
