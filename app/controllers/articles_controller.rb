class ArticlesController < ApplicationController
	def show
		@article = Article.find(params[:id])
		# byebug # used to stop execution and debug within the server console
	end

	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create
		# render plain: params[:article] # this can be used to plainly render this value back on the page, as another debugging tool
		@article = Article.new(params.require(:article).permit(:title, :description))
		# render plain: @article.inspect
		if @article.save
			# use a flash helper with a message
			flash[:notice] = "Article was created successfully."
			# redirect_to article_path(@article)
			# as an alternative shorthand, you can do the following and rails will know to redirect to that article
			redirect_to @article
		else
			render 'new' # re-renders the 'new' form, but now the article instance variable will have errors to display
		end
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(params.require(:article).permit(:title, :description))
			flash[:notice] = "Article was created successfully."
			redirect_to @article
		else
			render 'edit' # re-renders the 'edit' form, but now the article instance variable will have errors to display
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		redirect_to articles_path
	end
end