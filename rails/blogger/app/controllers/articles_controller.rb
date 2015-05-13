class ArticlesController < ApplicationController
  include ArticlesHelper
  before_filter :require_login, except: [:index, :show]

  
  def index
    @articles = Article.all
  end
  
  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article.id
  end
  
  def new
    @article ||= Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.author_id = current_user.id
    if @article.save
      flash.notice = "#{@article.title} created!"
      redirect_to article_path(@article)
    else
      redirect_to new_article_path(@article)
    end
  end
  
  def edit
    @article = Article.find(params[:id])
    unless @article.author_id == current_user.id
      flash.notice = "you may only edit your own articles"
      redirect_to @article
    end
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.author_id == current_user.id
      @article.update(article_params)
      flash.notice = "#{@article.title} updated!"
      redirect_to @article
    else
      flash.notice = "you may only edit your own articles"
      redirect_to @article
    end
  end
  
  def destroy
    article = Article.find(params[:id])
    article.delete
    flash.notice = "#{article.title} deleted!"
    redirect_to articles_path
  end
end
