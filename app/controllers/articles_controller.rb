class ArticlesController < ApplicationController
	def show
		@article = Article.find(params[:id])
		# byebug # used to stop execution and debug within the server console
	end

	def index
		@articles = Article.all
	end

	def new
	end

	def create
		# render plain: params[:article] # this can be used to plainly render this value back on the page, as another debugging tool
		@article = Article.new(params.require(:article).permit(:title, :description))
		# render plain: @article.inspect
		@article.save
		# redirect_to article_path(@article)
		# as an alternative shorthand, you can do the following and rails will know to redirect to that article
		redirect_to @article
	end
end