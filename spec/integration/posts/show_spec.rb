require 'rails_helper'

RSpec.describe 'GET /posts/:id', type: :system do
  let!(:user1) do
    User.create(name: 'Tom', photo: 'https://images.unsplash.com/photo-1461948573049-a5ab4efb6150?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2865&q=80',
                bio: 'Teacher from Mexico.')
  end

  let!(:user2) do
    User.create(name: 'Jerry', photo: 'https://images.unsplash.com/photo-1461948573049-a5ab4efb6150?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2865&q=80',
                bio: 'Teacher from Canada')
  end

  let!(:post) do
    Post.create(author_id: user1.id, title: 'Post 1', text: 'Yes its just a test')
  end

  let!(:comment) do
    Comment.create(post_id: post.id, author_id: user2.id, text: 'Comment 1')
  end

  before(:each) do
    visit user_post_path(user1, post)
    wait_for_page_to_load
  end

  def wait_for_page_to_load
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until page.evaluate_script('window.performance.timing.loadEventEnd') > 0
    end
  end

  it 'should display the post\'s title' do
    expect(page).to have_content(post.title)
  end

  it 'should show who is the author of the post' do
    expect(page).to have_content(user1.name)
  end

  it 'should show how many comments the post has' do
    expect(page).to have_content(post.comments_counter)
  end

  it 'should show how many likes the post has' do
    expect(page).to have_content(post.likes_counter)
  end

  it 'should show the post\'s text' do
    expect(page).to have_content(post.text)
  end

  it 'should show the username of the comment\'s author' do
    expect(page).to have_content('Jerry')
  end

  it 'should show the comment\'s text' do
    expect(page).to have_content(comment.text)
  end

  it 'should show the comment of each commentor left' do
    expect(page).to have_content("#{user2.name}:\n#{comment.text}")
  end
end
