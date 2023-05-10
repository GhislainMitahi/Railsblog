require 'rails_helper'

describe Comment, type: :model do
  it '#update_posts_comments_counter' do
    author = User.create!(
      name: Faker::Name.name,
      photo: Faker::Avatar.image,
      bio: Faker::Lorem.sentence
    )

    post = Post.create!(
      title: Faker::Lorem.sentence(word_count: 3),
      text: Faker::Lorem.paragraph,
      author: User.order(Arel.sql('RANDOM()')).first
    )

    2.times do
      Comment.create!(
        text: Faker::Lorem.sentence,
        author: author,
        post: post
      )
    end

    expect(post.comments_counter).to eq(2)
    Comment.create!(
      text: Faker::Lorem.sentence,
      author: author,
      post: post
    )

    expect(post.comments_counter).to eq(3)
  end
end
