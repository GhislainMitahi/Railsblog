class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :author, uniqueness: { scope: :post }

  after_save :update_posts_likes_counter

  private

  def update_posts_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
