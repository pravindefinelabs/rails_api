class ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: articles
  end

  def show
    @article = Article.find_by(id: params[:id])
    if @article.nil?
      render json: { error: "Article not found" }, status: :not_found
    else
      render json: @article, status: :ok  # 200
    end
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      render json: @article, status: :created
    else
      render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find_by(id: params[:id])

    if @article.nil?
      render json: { error: "Article not found" }, status: :not_found # 404
    elsif @article.destroy
      render json: { message: "Article deleted successfully" }, status: :ok # 200
    else
      render json: { error: "Failed to delete article" }, status: :unprocessable_entity # 422
    end
  end

  def update
    @article = Article.find_by(id: params[:id])

    if @article.nil?
      render json: { error: "Article not found" }, status: :not_found
    elsif @article.update(article_params) # `update` already saves changes
      render json: @article, status: :ok
    else
      render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
