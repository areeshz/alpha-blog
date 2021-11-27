class ArticlesController < ApplicationController
	def show
		@article = Article.find(params[:id])
		# byebug # used to stop execution and debug within the server console
	end
end