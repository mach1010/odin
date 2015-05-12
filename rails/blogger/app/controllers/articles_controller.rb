class ArticlesController < ApplicationController
  include ArticlesHelper
  
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
    if @article.save
      flash.notice = "#{@article.title} created!"
      redirect_to article_path(@article)
    else
      redirect_to new_article_path(@article)
    end
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    flash.notice = "#{@article.title} updated!"
    redirect_to @article
  end
  
  def destroy
    article = Article.find(params[:id])
    article.delete
    flash.notice = "#{article.title} deleted!"
    redirect_to articles_path
  end
  
  

end
