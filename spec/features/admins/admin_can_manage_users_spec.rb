require 'rails_helper'

describe 'Admin' do
  before(:each) do
    DatabaseCleaner.clean
    @users = create_list(:user, 5)
  end

  after(:each) do
    DatabaseCleaner.clean
    FactoryBot.reload
  end

  scenario 'can see all users' do
    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_users_path

    expect(page).to_not have_content('Admin Users Console')
    expect(page).to have_content(@users.first.name)
    expect(page).to have_content(@users.last.email)
  end

  scenario 'can create a new default user' do
    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_users_path

    expect(page).to_not have_content('User 6')

    click_on 'Create a New User'

    expect(current_path).to eq(new_admin_user_path)

    fill_in 'user[name]', with: 'User 6'
    fill_in 'user[email]', with: 'test@mail.com'
    fill_in 'user[password]', with: 'password'
    select 'default', from: 'user[role]'

    click_on 'Create User'

    expect(current_path).to eq(admin_users_path)
    expect(page).to have_content('User 6')
    expect(User.last.default?).to be_truthy
  end

  scenario 'can create a new admin user' do
    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_users_path

    expect(page).to_not have_content('Admin 2')

    click_on 'Create a New User'

    expect(current_path).to eq(new_admin_user_path)

    fill_in 'user[name]', with: 'Admin 2'
    fill_in 'user[email]', with: 'test@mail.com'
    fill_in 'user[password]', with: 'password'
    select 'admin', from: 'user[role]'

    click_on 'Create User'

    expect(current_path).to eq(admin_users_path)
    expect(page).to have_content('Admin 2')
    expect(User.last.admin?).to be_truthy
  end

  scenario 'can edit a user' do
    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_users_path

    expect(page).to have_content(@users.first.name)

    within '.card:first-child' do
      click_on 'Edit User'
    end

    expect(current_path).to eq(edit_admin_user_path(@users.first))

    fill_in 'user[name]', with: 'Test Name'
    click_on 'Update User'

    expect(current_path).to eq(admin_users_path)
    within '.card:first-child' do
      expect(page).to have_content('Test Name')
    end
  end

  scenario 'can delete a user' do
    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_users_path

    expect(page).to have_content(@users.first.name)

    within '.card:first-child' do
      click_on 'Delete User'
    end

    expect(page).to have_content(@users.first.name)
  end

  scenario 'default user can\'t see the admin users console' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_users_path

    expect(page).to_not have_content('Admin Users Console')
    expect(page).to have_content('The page you were looking for doesn\'t exist')
  end
end
