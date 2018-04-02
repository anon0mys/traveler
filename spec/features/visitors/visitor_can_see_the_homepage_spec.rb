require 'rails_helper'

describe 'Visitor' do
  scenario 'can navigate to the home page' do
    visit '/'

    expect(page).to have_content('Traveller')
  end
end
