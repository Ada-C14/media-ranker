require 'test_helper'

class WorkControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get work_index_url
    assert_response :success
  end

  test "should get show" do
    get work_show_url
    assert_response :success
  end

  test "should get update" do
    get work_update_url
    assert_response :success
  end

  test "should get edit" do
    get work_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get work_destroy_url
    assert_response :success
  end

  test "should get new" do
    get work_new_url
    assert_response :success
  end

  test "should get create" do
    get work_create_url
    assert_response :success
  end

end
