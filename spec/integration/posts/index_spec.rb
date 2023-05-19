require 'rails_helper'

RSpec.describe 'GET /posts', type: :system do
  let!(:user) do
    User.create(name: 'Tom', photo: 'https://images.unsplash.com/photo-1461948573049-a5ab4efb6150?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2865&q=80',
                bio: 'Teacher from Mexico.')
  end

  10.times do |i|
    let!("p#{i}".to_sym) do
      Post.create(author_id: user.id, title: "Post #{i}", text: "Yes its just a test #{i}")
    end
  end

  3.times do |i|
    let!("c#{i}".to_sym) do
      Comment.create(post_id: p0.id, author_id: user.id, text: "Comment #{i}")
    end
  end

  before(:each) do
    visit user_posts_path(user)
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

  it 'should display the number of posts the user has' do
    expect(page).to have_content(user.posts_counter)
  end

  it 'should display post\'s title' do
    expect(page).to have_content(p0.title)
  end

  it 'should display post\'s body' do
    expect(page).to have_content(p0.text)
  end

  it 'should display the first comments on the post' do
    expect(page).to have_content(c0.text)
    expect(page).to have_content(c1.text)
    expect(page).to have_content(c2.text)
  end

  it 'should display the number of comments the post has' do
    expect(page).to have_content(p0.comments_counter)
  end

  it 'should display the number of likes the post has' do
    expect(page).to have_content(p0.likes_counter)
  end

  it 'should have section for pagination if there are more posts than fit on the view' do
    expect(page).to have_button('Next')
  end

  it 'redirects to the post\'s show page when clicking on the post\'s title' do
    click_on p0.title
    expect(page).to have_current_path(user_post_path(user, p0))
  end
end
