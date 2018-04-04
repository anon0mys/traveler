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
end
