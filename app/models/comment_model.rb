class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post

  private

  def update_counter
    count_comments = Comment.where(post_id: post_id).count
    Post.find_by(id: post_id).update(commentsCounter: count_comments)
  end
end
