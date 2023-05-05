class LikeModel < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'
  after_save :update_likes_counter

  private

  def update_counter
    count_likes = Like.where(post_id: post_id).count
    Post.find_by(id: post_id).update(likesCounter: count_likes)
  end
end
