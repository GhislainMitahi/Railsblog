require 'rails_helper'

describe 'Posts', type: :request do
  let!(:user) do
    User.create!(
      name: Faker::Name.name,
      bio: Faker::Lorem.sentence,
      photo: Faker::Avatar.image
    )
  end
  let!(:post) do
    Post.create!(
      title: Faker::Lorem.sentence(word_count: 3),
      text: Faker::Lorem.paragraph,
      author: user
    )
  end

  describe 'GET #index' do
    it 'returns http success' do
      get user_posts_path(user.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get user_posts_path(user.id)
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      get user_posts_path(user.id)
      expect(response.body).to include(user.name)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get user_post_path(user.id, post.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_post_path(user.id, post.id)
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      get user_post_path(user.id, post.id)
      expect(response.body).to include(post.title)
    end
  end
end
