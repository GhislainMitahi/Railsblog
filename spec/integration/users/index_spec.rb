require 'rails_helper'

RSpec.describe 'GET /users', type: :system do
  let!(:user1) do
    User.create(name: 'Tom', photo: 'https://images.unsplash.com/photo-1461948573049-a5ab4efb6150?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2865&q=80',
                bio: 'Teacher from Mexico.')
  end

  let!(:user2) do
    User.create(name: 'John', photo: 'https://images.unsplash.com/photo-1461948573049-a5ab4efb6150?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2865&q=80',
                bio: 'Teacher from Canada.')
  end

  it 'should display the username of all other users' do
    visit '/users'
    expect(page).to have_content(user1.name)
    expect(page).to have_content(user2.name)
  end

  it 'should display the photo of all other users' do
    visit '/users'
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1461948573049-a5ab4efb6150?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdl']")
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1461948573049-a5ab4efb6150?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdl']")
  end

  it 'should display the number of posts of all other users' do
    visit '/users'
    expect(page).to have_content(user1.posts_counter)
    expect(page).to have_content(user2.posts_counter)
  end

  it 'redirects to the user page when clicking on the username' do
    visit '/users'
    click_on user1.name
    expect(page).to have_current_path("/users/#{user1.id}")
  end
end
