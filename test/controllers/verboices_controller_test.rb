require 'test_helper'

class VerboicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get verboices_index_url
    assert_response :success
  end

  test "should get create" do
    get verboices_create_url
    assert_response :success
  end

end
