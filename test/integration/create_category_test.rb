require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = User.create(username: "admin", email: "admin@example.com", password: "password", admin: true)
    sign_in_as @admin_user
  end

  test "get new category form and create category" do
    get "/categories/new" # can also be written as--> get new_category_url
    assert_response :success
    assert_match "Create a new category", response.body

    assert_difference 'Category.count', 1 do 
      post categories_path, params: { category: { name: "Sports" } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end

  test "get new category form and reject invalid category submission" do
    get new_category_url

    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: 'A very long name for a category'}}
    end

    assert_match "errors", response.body
    assert_select 'div.alert.alert-danger'
    assert_select 'h4.alert-heading'
  end
end
