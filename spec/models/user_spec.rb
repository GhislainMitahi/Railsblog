require 'rails_helper'

describe User, type: :model do
  it 'is valid with all correct arguments' do
    author = User.create!(
      name: Faker::Name.name,
      photo: Faker::Avatar.image,
      bio: Faker::Lorem.sentence
    )
    expect(author).to be_valid
  end

  it 'is invalid without a name' do
    author = User.new(
      name: nil,
      photo: Faker::Avatar.image,
      bio: Faker::Lorem.sentence
    )
    expect(author).to_not be_valid
  end

  it 'posts_counter is a positive integer' do
    author = User.new(
      name: Faker::Name.name,
      photo: Faker::Avatar.image,
      bio: Faker::Lorem.sentence,
      posts_counter: -1
    )
    expect(author).to_not be_valid
  end

  it '#recent_posts' do
    author = User.create!(
      name: Faker::Name.name,
      photo: Faker::Avatar.image,
      bio: Faker::Lorem.sentence
    )
    10.times do
      Post.create!(
        title: Faker::Lorem.sentence(word_count: 3),
        text: Faker::Lorem.paragraph,
        author: author
      )
    end
    last_3_posts = author.recent_posts
    expect(last_3_posts.size).to eq(3)
  end
end
