require 'rails_helper'

describe 'Anyone' do
  before(:each) do
    DatabaseCleaner.clean
    @user_one = create(:user)
    @user_two = create(:user)
    @locations = create_list(:location, 5)
    @user_one_posts = create_list(:post, 5, user: @user_one, location: @locations.first)
    @user_two_posts = create_list(:post, 5, user: @user_two, location: @locations.first)
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
      expect(page).to have_content(@user_one_posts[2].location.country.name)
      expect(page).to have_content(@user_two_posts.last.location.country.name)
    end

    scenario 'should be able to click on post title to go to show page' do
      visit posts_path

      click_on @user_one_posts.first.title

      expect(current_path).to eq(post_path(@user_one_posts.first))
    end
  end

  context 'on the users index' do
    scenario 'should see all users' do
      visit users_path

      expect(page).to have_content(@user_one.name)
      expect(page).to have_content(@user_two.name)
      expect(page).to have_content(@user_one.posts.count)
      expect(page).to have_content(@user_two.top_three_locations.keys.first)
    end

    scenario 'should be able to click on users name to go to show page' do
      visit users_path

      within '.card:first-child' do
        click_on @user_one.name
      end

      expect(current_path).to eq(user_path(@user_one))
    end
  end
end
