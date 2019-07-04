class BlogsController < ApplicationController
  def index
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to :root
    else
      render 'new'
    end
  end

  def index
    @post = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(post_params)
    redirect_to :root
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to blogs_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :category, :content)
    end
end
