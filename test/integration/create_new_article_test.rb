require "test_helper"

class CreateNewArticleTest < ActionDispatch::IntegrationTest
	def setup
		@user = User.create(username: 'violet', email: 'violet@example.com', password: 'password')
		sign_in_as @user
		Article.create(title: 'seed article', description: 'seeded article')
	end

	test "must be logged in to create article" do
		log_out

		assert_no_difference 'Article.count' do
			post articles_path, params: { article: { title: 'an article title', description: 'a description'}}
		end
		assert_response :redirect
		assert_redirected_to login_url
	end

	test "get article form and create article" do
		get new_article_url
		assert_response :success

		assert_match "Create a new article", response.body
		assert_select "form[action=?]", articles_path

		assert_difference 'Article.count', 1 do
			post articles_path, params: { article: { title: 'an article title', description: 'a description'}}
		end

		assert_response :redirect
		assert_redirected_to article_path(Article.last)
		
		follow_redirect!
		assert_match Article.last.title, response.body
	end

	test "reject invalid article creation" do
		get new_article_url
		assert_response :success

		assert_no_difference 'Article.count' do
			post articles_path, params: { article: { title: 'an article title', description: '2short'}}
		end

		assert_match "errors", response.body
		assert_select 'div.alert.alert-danger'
		assert_select 'h4.alert-heading'
	end
end
