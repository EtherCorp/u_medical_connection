require 'test_helper'

class JsonsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get jsons_index_url
    assert_response :success
  end

  test "should get new" do
    get jsons_new_url
    assert_response :success
  end

  test "should get create" do
    get jsons_create_url
    assert_response :success
  end

  test "should get edit" do
    get jsons_edit_url
    assert_response :success
  end

  test "should get update" do
    get jsons_update_url
    assert_response :success
  end

  test "should get destroy" do
    get jsons_destroy_url
    assert_response :success
  end

end
