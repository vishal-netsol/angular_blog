class BlogsController < ApplicationController

  def index
    @blogs = Blog.all
  end

  def create
    @blog = Blog.create!(blog_params)
    render 'show', status: 201
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def update
    blog = Blog.find(params[:id])
    blog.update_attributes(blog_params)
    head :no_content
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy
    head :no_content
  end

private

  def blog_params
    params.fetch(:blog, {}).permit(:title, :content)
  end

end
