require 'test_helper'

class UploadCsvControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
