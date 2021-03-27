require 'test_helper'

class BroadcastControllerTest < ActionController::TestCase
  test "should get select_file" do
    get :select_file
    assert_response :success
  end

  test "should get mail_entry" do
    get :mail_entry
    assert_response :success
  end

  test "should get confirm_email" do
    get :confirm_email
    assert_response :success
  end

  test "should get preview_all" do
    get :preview_all
    assert_response :success
  end

  test "should get sent_message" do
    get :sent_message
    assert_response :success
  end

end
