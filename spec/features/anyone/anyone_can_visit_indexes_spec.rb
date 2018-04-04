require 'rails_helper'

describe 'Anyone' do
  before(:each) do
    DatabaseCleaner.clean
    @user_one = create(:user)
    @user_two = create(:user)
    @location = create(:location)
    @user_one_posts = create_list(:post, 5, user: @user_one, location: @location)
    @user_two_posts = create_list(:post, 5, user: @user_two, location: @location)
  end

  after(:each) do
    DatabaseCleaner.clean
    FactoryBot.reload
  end

  context 'on the posts index' do
    scenario 'should see all posts' do
      visit posts_path

      expect(page).to have_content(@user_one_posts.first.title)
      expect(page).to have_content(@user_two_posts.last.title)
      expect(page).to have_content(@user_one_posts[2].location.country)
      expect(page).to have_content(@user_two_posts.last.location.state)
    end

    scenario 'should be able to click on post title to go to show page' do
      visit posts_path

      click_on @user_one_posts.first.title

      expect(current_path).to eq(post_path(@user_one_posts.first))
    end
  end
end
