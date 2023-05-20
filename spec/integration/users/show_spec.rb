require 'rails_helper'

RSpec.describe 'GET /users/:id', type: :system do
  let!(:user) do
    User.create(name: 'Tom', photo: 'https://images.unsplash.com/photo-1461948573049-a5ab4efb6150?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdl',
                bio: 'Teacher from Mexico.')
  end

  5.times do |i|
    let!("post#{i}".to_sym) do
      Post.create(author_id: user.id, title: "Post #{i}", text: "Text #{i}")
    end
  end

  before(:each) do
    visit user_path(user)
    wait_for_page_to_load
  end

  def wait_for_page_to_load
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until page.evaluate_script('window.performance.timing.loadEventEnd') > 0
    end
  end

  it 'should display the user\'s profile picture' do
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1461948573049-a5ab4efb6150?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdl']")
  end

  it 'should display the user\'s name' do
    expect(page).to have_content(user.name)
  end

  it 'should display the user\'s bio' do
    expect(page).to have_content(user.bio)
  end

  it 'should display the user\'s number of posts' do
    expect(page).to have_content(user.posts_counter)
  end

  it 'should display the user\'s first 3 posts' do
    expect(page).to have_content(post0.title)
    expect(page).to have_content(post1.title)
    expect(page).to have_content(post2.title)
  end

  it 'should not display the user\'s 4th and 5th post' do
    expect(page).not_to have_content(post3.title)
    expect(page).not_to have_content(post4.title)
  end

  it 'redirects to the user\'s post page when clicking on the post title' do
    click_on post0.title
    expect(page).to have_current_path(user_post_path(user, post0))
  end

  it 'redirects to the post\'s index page when clicking on the \'See all posts\' button' do
    click_on 'See all posts'
    expect(page).to have_current_path(user_posts_path(user))
  end
end
