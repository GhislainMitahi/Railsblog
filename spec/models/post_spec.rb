require 'rails_helper'

describe Post, type: :model do
  let(:author) do
    User.create!(
      name: Faker::Name.name,
      photo: Faker::Avatar.image,
      bio: Faker::Lorem.sentence
    )
  end

  it 'title isn\'t longer than 250 characters' do
    post = Post.new(
      title: Faker::Lorem.characters(number: 251),
      text: Faker::Lorem.paragraph,
      author: author
    )
    expect(post).to_not be_valid
  end

  it 'comments_counter is a positive integer' do
    post = Post.new(
      title: Faker::Lorem.sentence(word_count: 3),
      text: Faker::Lorem.paragraph,
      comments_counter: -1,
      author: author
    )
    expect(post).to_not be_valid
  end

  it 'likes_counter is a positive integer' do
    post = Post.new(
      title: Faker::Lorem.sentence(word_count: 3),
      text: Faker::Lorem.paragraph,
      likes_counter: -1,
      author: author
    )
    expect(post).to_not be_valid
  end

  it 'is valid with all correct arguments' do
    post = Post.create!(
      title: Faker::Lorem.sentence(word_count: 3),
      text: Faker::Lorem.paragraph,
      author: author
    )
    expect(post).to be_valid
  end

  it 'is invalid without a title' do
    post = Post.new(
      title: nil,
      text: Faker::Lorem.paragraph,
      author: author
    )
    expect(post).to_not be_valid
  end

  it '#recent_comments' do
    post = Post.create!(
      title: Faker::Lorem.sentence(word_count: 3),
      text: Faker::Lorem.paragraph,
      author: author
    )

    10.times do
      Comment.create!(
        text: Faker::Lorem.sentence,
        author: author,
        post: post
      )
    end
    last_5_comments = post.recent_comments
    expect(last_5_comments.size).to eq(5)
  end

  it '#update_user_posts_counter' do
    5.times do
      Post.create!(
        title: Faker::Lorem.sentence(word_count: 3),
        text: Faker::Lorem.paragraph,
        author: author
      )
    end
    expect(author.posts_counter).to eq(5)
  end
end
