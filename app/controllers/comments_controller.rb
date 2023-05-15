class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])

    @comment = Comment.new(
      text: params[:comment][:text],
      author: current_user,
      post_id: params[:post_id]
    )
    if @comment.save
      redirect_to user_post_path(@post, @current_user)
    else
      flash[:error] = 'Post could not be saved'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :text)
  end
end
