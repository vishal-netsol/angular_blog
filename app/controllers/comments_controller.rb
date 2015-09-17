class CommentsController < ApplicationController
  before_filter :load_blog

  def index
    @comments = @blog.comments
  end

  def create
    @comment = @blog.comments.create!(comment_params)
    render 'show', status: 201
  end

  def show
    @comment = @blog.comments.find(params[:id])
  end

  def update
    comment = @blog.comments.find(params[:id])
    comment.update_attributes(comment_params)
    head :no_content
  end

  def destroy
    comment = @blog.comments.find(params[:id])
    comment.destroy
    head :no_content
  end

private

  def load_blog
    @blog = Blog.find(params[:blog_id])
  end

  def comment_params
    params.fetch(:comment, {}).permit(:content, :blog_id)
  end

end
