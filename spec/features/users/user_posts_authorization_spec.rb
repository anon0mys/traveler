require 'rails_helper'

describe 'User' do
  context 'from the post paths' do
    before(:each) do
      DatabaseCleaner.clean
      @user_one = create(:user)
      @user_two = create(:user)
      @location = create(:location)
      @user_one_posts = create_list(:post, 5, user: @user_one, location: @location)
      @user_two_posts = create_list(:post, 5, user: @user_two, location: @location)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_one)
    end

    after(:each) do
      DatabaseCleaner.clean
      FactoryBot.reload
    end

    scenario 'can\'t edit someone else\'s posts' do
      visit edit_user_post_path(@user_two, @user_two.posts.first)

      expect(page).to_not have_content('Edit Post')
      expect(page).to have_content('The page you were looking for doesn\'t exist')
    end

    scenario 'can\'t delete someone else\'s posts' do
      visit user_post_path(@user_two, @user_two_posts.first)

      expect(page).to_not have_content('Delete Post')
    end
  end

  context 'on another user\'s show page' do
    before(:each) do
      DatabaseCleaner.clean
      @user_one = create(:user)
      @user_two = create(:user)
      @location = create(:location)
      @user_one_posts = create_list(:post, 5, user: @user_one, location: @location)
      @user_two_posts = create_list(:post, 5, user: @user_two, location: @location)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_one)
    end

    after(:each) do
      DatabaseCleaner.clean
      FactoryBot.reload
    end

    scenario 'can see someone else\'s posts' do
      visit user_path(@user_two)

      expect(page).to have_content(@user_two_posts.first.title)
      expect(page).to have_content(@user_two_posts[2].title)
      expect(page).to have_content(@user_two_posts.last.title)
    end

    scenario 'can\'t edit someone else\'s posts' do
      visit user_path(@user_two)

      within '.card:first-child' do
        expect(page).to_not have_content('Edit')
      end
    end

    scenario 'can\'t delete someone else\'s posts' do
      visit user_path(@user_two)

      within '.card:first-child' do
        expect(page).to_not have_button('Delete')
      end
    end
  end
end
