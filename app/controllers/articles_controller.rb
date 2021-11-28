class ArticlesController < ApplicationController
	# the following line causes the "set_article" method to be run before the mentioned actions
	# it seemingly sets the @article instance variable within the scope of those methods / actions
	before_action :set_article, only: [:show, :edit, :update, :destroy]

	def show
		# byebug # used to stop execution and debug within the server console
	end

	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end

	def edit
	end

	def create
		# render plain: params[:article] # this can be used to plainly render this value back on the page, as another debugging tool
		@article = Article.new(article_params)
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
		if @article.update(article_params)
			flash[:notice] = "Article was updated successfully."
			redirect_to @article
		else
			render 'edit' # re-renders the 'edit' form, but now the article instance variable will have errors to display
		end
	end

	def destroy
		@article.destroy
		redirect_to articles_path
	end

	private

	def set_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :description)
	end

end