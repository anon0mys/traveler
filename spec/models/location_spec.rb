require 'rails_helper'

RSpec.describe Location do
  it { should have_many(:posts) }
  it { should have_many(:users).through(:posts) }

  describe 'class methods' do
    before(:each) do
      DatabaseCleaner.clean
      @user = create(:user)
      @location_one = create(:location, lat: 39.742043, long: -104.991531)
      @location_two = create(:location, lat: 39.742043, long: -104.991531)
      @location_three = create(:location, lat: 39.742043, long: -104.991531)
      @location_four = create(:location, lat: 39.742043, long: -104.991531)
      @location_five = create(:location, lat: 39.742043, long: -104.991531)
      create_list(:post, 10, user: @user, location: @location_one)
      create_list(:post, 1, user: @user, location: @location_two)
      create_list(:post, 5, user: @user, location: @location_three)
      create_list(:post, 3, user: @user, location: @location_four)
      create_list(:post, 6, user: @user, location: @location_five)
    end

    after(:each) do
      DatabaseCleaner.clean
      FactoryBot.reload
    end

    it 'should sum all posts by country' do
      result = Location.sum_of_countries
      expected = [['Country 1', 10],
                  ['Country 5', 6],
                  ['Country 3', 5],
                  ['Country 4', 3],
                  ['Country 2', 1]]

      expect(result).to eq(expected)
    end

    it 'should create a lat long hash for maps' do
      result = Location.maps_loc_prep
      expected = [['Country 1', 10],
                  ['Country 5', 6],
                  ['Country 3', 5],
                  ['Country 4', 3],
                  ['Country 2', 1]]

      expect(result).to eq(expected)
    end
  end
end
