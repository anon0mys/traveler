require 'rails_helper'

RSpec.describe Location do
  it { should have_many(:posts) }
  it { should have_many(:users).through(:posts) }

  describe 'class methods' do
    it 'should sum all posts by location' do
      DatabaseCleaner.clean
      @user = create(:user)
      @location_one = create(:location)
      @location_two = create(:location)
      @location_three = create(:location)
      @location_four = create(:location)
      @location_five = create(:location)
      create_list(:post, 10, user: @user, location: @location_one)
      create_list(:post, 1, user: @user, location: @location_two)
      create_list(:post, 5, user: @user, location: @location_three)
      create_list(:post, 3, user: @user, location: @location_four)
      create_list(:post, 6, user: @user, location: @location_five)

      result = Location.sum_of_countries
      expected = [['Country 1', 10],
                  ['Country 5', 6],
                  ['Country 3', 5],
                  ['Country 4', 3],
                  ['Country 2', 1]]

      expect(result).to eq(expected)
    end
  end
end
