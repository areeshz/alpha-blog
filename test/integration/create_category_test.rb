require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
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
end
