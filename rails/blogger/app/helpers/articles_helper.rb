module ArticlesHelper
  def article_params
    params.require(:article).permit(:title, :body, :tag_list, :image)
  end
  
  def edit_by_author_only
    current_user.id == @article.author_id
  end
end
