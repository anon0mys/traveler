require 'rails_helper'

describe 'Authentication' do
  scenario 'a user can create an account' do
    visit root_path

    click_on 'Create an Account'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[name]', with: 'User Name'
    fill_in 'user[email]', with: 'user@email.com'
    fill_in 'user[password]', with: 'password'
    click_on 'Create Account'

    expect(current_path).to eq user_path(User.last)
    expect(page).to have_content(User.last.name)
  end

  scenario 'a user can log in to their account' do
    user = User.create(name: 'Name', email: 'email@mail.com', password: 'password')
    visit root_path

    click_on 'Log In'

    expect(current_path).to eq(login_path)

    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    within '.buttons' do
      click_on 'Log In'
    end

    expect(current_path).to eq user_path(user)
    expect(page).to have_content("Welcome, #{user.name}")
    expect(page).to have_content("Log Out")
  end

  scenario 'a user can log out of their account' do
    user = User.create(name: 'Name', email: 'email@mail.com', password: 'password')
    visit root_path
    click_on 'Log In'

    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    within '.buttons' do
      click_on 'Log In'
    end

    expect(current_path).to eq user_path(user)

    click_on 'Log Out'

    expect(current_path).to eq(root_path)
    expect(page).to_not have_content("Log Out")

    visit user_path(user)

    expect(page).to_not have_content("Welcome, #{user.name}")
  end
end
