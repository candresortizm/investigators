require 'test_helper'

class Api::V1::DataImportsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_data_imports_create_url
    assert_response :success
  end

end
