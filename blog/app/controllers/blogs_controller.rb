class BlogsController < ApplicationController
  def index
  end

  def create
    @post = Post.new(post_params)
    puts post_params
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def index
    @post = Post.all
  end

  def new
  end

  private
    def post_params
      params.require(:post).permit(:title, :category, :content)
    end
end
