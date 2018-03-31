require 'rails_helper'

describe 'Visitor' do
  context 'can create an account' do
    scenario 'from create account path' do
      visit new_user_path

      fill_in 'user[name]', with: 'User Name'
      fill_in 'user[email]', with: 'user@email.com'
      fill_in 'user[password]', with: 'password'
      click_on 'Create Account'

      expect(current_path).to eq user_path
      expect(page).to have_content(User.last.name)
    end
  end
end
