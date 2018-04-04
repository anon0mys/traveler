require 'rails_helper'

describe 'User' do
  scenario 'can create a post' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_path(user)

    click_on 'Add an Adventure'

    expect(current_path).to eq(new_user_post_path(user))

    fill_in 'post[title]', with: 'Adventure 1'
    fill_in 'post[location][state]', with: 'Colorado'
    select 'USA', from: 'post[location][country]'
    fill_in 'post[body]', with: 'A description of the adventure.'

    click_on 'Create Adventure'

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content(Post.last.title)
  end

  context 'on their show page' do
    before(:each) do
      DatabaseCleaner.clean
      @user = create(:user)
      @location = create(:location)
      @posts = create_list(:post, 5, user: @user, location: @location)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    after(:each) do
      DatabaseCleaner.clean
      FactoryBot.reload
    end

    scenario 'can see their own posts on their show page' do
      visit user_path(@user)

      expect(page).to have_content(@posts.first.title)
      expect(page).to have_content(@posts[2].title)
      expect(page).to have_content(@posts.last.title)
    end

    scenario 'can edit their own posts' do
      visit user_path(@user)

      within '.card:first-child' do
        expect(page).to have_content(@posts.first.title)
        click_on 'Edit'
      end

      expect(current_path).to eq(edit_user_post_path(@user, @posts.first))
      expect(page).to have_content('Edit Post')

      fill_in 'post[title]', with: 'A new title'

      click_on 'Update Adventure'

      expect(current_path).to eq(user_path(@user))
      expect(page).to have_content('A new title')
    end

    scenario 'can delete their own posts' do
      visit user_path(@user)

      expect(page).to have_content(@posts.first.title)

      within '.card:first-child' do
        click_on 'Delete'
      end

      expect(current_path).to eq(user_path(@user))
      expect(page).to_not have_content(@posts.first.title)
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
