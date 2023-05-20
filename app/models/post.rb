class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_user_posts_counter

  def recent_comments(limit = 5)
    comments.includes(:author).order(created_at: :desc).limit(limit)
  end

  private

  def update_user_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
