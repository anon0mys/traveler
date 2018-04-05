require 'rails_helper'

describe 'Anyone' do
  before(:each) do
    DatabaseCleaner.clean
    @user = create(:user)
    @location_one = create(:location, lat: 39.742043, lng: -104.991531)
    @location_two = create(:location, lat: 39.742043, lng: -104.991531)
    @location_three = create(:location, lat: 39.742043, lng: -104.991531)
    @location_four = create(:location, lat: 39.742043, lng: -104.991531)
    @location_five = create(:location, lat: 39.742043, lng: -104.991531)
    @loc_one_posts = create_list(:post, 10, user: @user, location: @location_one)
    @loc_two_posts = create_list(:post, 1, user: @user, location: @location_two)
    @loc_three_posts = create_list(:post, 5, user: @user, location: @location_three)
    @loc_four_posts = create_list(:post, 3, user: @user, location: @location_four)
    @loc_five_posts = create_list(:post, 6, user: @user, location: @location_five)
  end

  after(:each) do
    DatabaseCleaner.clean
    FactoryBot.reload
  end

  scenario 'can visit locations show path to see posts at that location' do
    visit location_path(@location_one)
    expect(page).to have_content(@loc_one_posts.first.title)
    expect(page).to have_content(@loc_one_posts.last.title)

    visit location_path(@location_three)
    expect(page).to have_content(@loc_three_posts.first.title)
    expect(page).to have_content(@loc_three_posts.last.title)
  end
end
