require 'rails_helper'

describe 'Users', type: :request do
  let!(:user) do
    User.create!(
      name: Faker::Name.name,
      bio: Faker::Lorem.sentence,
      photo: Faker::Avatar.image
    )
  end

  describe 'GET #index' do
    it 'returns http success' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('All Users')
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get user_path(user.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_path(user.id)
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      get user_path(user.id)
      expect(response.body).to include(user.name)
    end
  end
end
