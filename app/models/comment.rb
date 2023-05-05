class CommentModel < ApplicationRecord
  elongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :update_comments_counter

  private

  def update_counter
    count_comments = Comment.where(post_id: post_id).count
    Post.find_by(id: post_id).update(commentsCounter: count_comments)
  end
end
