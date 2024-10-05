require "test_helper"

class PlaceholdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @placeholder = placeholders(:one)
  end

  test "should get index" do
    get placeholders_url
    assert_response :success
  end

  test "should get new" do
    get new_placeholder_url
    assert_response :success
  end

  test "should create placeholder" do
    assert_difference("Placeholder.count") do
      post placeholders_url, params: {placeholder: {account_id: @placeholder.account_id, name: @placeholder.name, step_id: @placeholder.step_id}}
    end

    assert_redirected_to placeholder_url(Placeholder.last)
  end

  test "should show placeholder" do
    get placeholder_url(@placeholder)
    assert_response :success
  end

  test "should get edit" do
    get edit_placeholder_url(@placeholder)
    assert_response :success
  end

  test "should update placeholder" do
    patch placeholder_url(@placeholder), params: {placeholder: {account_id: @placeholder.account_id, name: @placeholder.name, step_id: @placeholder.step_id}}
    assert_redirected_to placeholder_url(@placeholder)
  end

  test "should destroy placeholder" do
    assert_difference("Placeholder.count", -1) do
      delete placeholder_url(@placeholder)
    end

    assert_redirected_to placeholders_url
  end
end
