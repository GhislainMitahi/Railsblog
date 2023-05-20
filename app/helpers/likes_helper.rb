module LikesHelper
  def like_link(post)
    like = current_user.like_for(post)
    if like
      button_to 'Unlike', user_post_like_path(post.author, post, like), method: :delete
    else
      button_to 'Like', user_post_likes_path(post.author, post), method: :post
    end
  end
end
