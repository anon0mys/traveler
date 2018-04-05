require 'rails_helper'

RSpec.describe User do
  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should have_many(:locations).through(:posts) }

  describe 'roles' do
    it 'should be admin when role is 1' do
      admin = create(:user, role: 1)

      expect(admin.admin?).to be_truthy
      expect(admin.role).to eq 'admin'
    end

    it 'should default to role 0' do
      admin = create(:user)

      expect(admin.default?).to be_truthy
      expect(admin.role).to eq 'default'
    end
  end

  describe 'class methods' do
    it 'should find top three locations' do
      @user = create(:user)
      @location_one = create(:location)
      @location_two = create(:location)
      @location_three = create(:location)
      @location_four = create(:location)
      create_list(:post, 6, user: @user, location: @location_one)
      create_list(:post, 1, user: @user, location: @location_two)
      create_list(:post, 4, user: @user, location: @location_three)
      create_list(:post, 5, user: @user, location: @location_four)

      expect(@user.top_three_locations.keys.first).to eq('Country 1')
      expect(@user.top_three_locations.keys[1]).to eq('Country 4')
      expect(@user.top_three_locations.keys.last).to eq('Country 3')

      create_list(:post, 10, user: @user, location: @location_two)

      expect(@user.top_three_locations.keys.first).to eq('Country 2')
      expect(@user.top_three_locations.keys[1]).to eq('Country 1')
      expect(@user.top_three_locations.keys.last).to eq('Country 4')
    end
  end
end
