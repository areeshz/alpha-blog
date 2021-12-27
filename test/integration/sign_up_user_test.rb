require "test_helper"

class SignUpUserTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'get signup form and sign up user' do
    get signup_url
    assert_response :success
    assert_match 'Sign up for Alpha Blog', response.body
    assert_select 'form[action=?]', users_path

    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: 'testUser', email: 'test@example.com', password: 'password' } }
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match "Listing all articles", response.body
  end

  test 'reject invalid user signup' do
    get signup_url
    assert_response :success

    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: 'testUser', email: 'test@example.com'} }
    end

    assert_match 'errors', response.body
    assert_select 'div.alert.alert-danger'
    assert_select 'h4.alert-heading'
  end
end
