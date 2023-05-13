module LikesHelper
  def like_link(post)
    if current_user.likes?(post)
      button_to 'Unlike', user_post_like_path(post.author, post, current_user.like_for(post)), method: :delete,
                                                                                               class: 'border-2 p-2'
    else
      button_to 'Like', user_post_likes_path(post.author, post), class: 'border-2 p-2'
    end
  end
end
