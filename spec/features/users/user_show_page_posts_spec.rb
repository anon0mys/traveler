require 'rails_helper'

describe 'User' do
  scenario 'can create a post' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_path(user)

    within '.dropdown-menu' do
      click_on 'Add an Adventure'
    end

    expect(current_path).to eq(new_user_post_path(user))

    fill_in 'post[title]', with: 'Adventure 1'
    select 'United States', from: 'post[location][country]'
    fill_in 'post[location][lat]', with: 39.742043
    fill_in 'post[location][lng]', with: -104.991531
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

    scenario 'can navigate to their post show page' do
      visit user_path(@user)

      click_on @posts.first.title

      expect(current_path).to eq(post_path(@posts.first))

      expect(page).to have_content(@posts.first.title)
      expect(page).to have_content(@posts.first.body)
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
end
