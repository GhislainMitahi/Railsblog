class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.all
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      title: params[:post][:title],
      text: params[:post][:text],
      author: current_user
    )

    if @post.save
      redirect_to user_post_path(@post.author, @post)
    else
      flash[:error] = 'Post could not be saved'
      redirect_to user_posts_path(@post.author)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
