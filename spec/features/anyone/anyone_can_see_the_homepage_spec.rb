require 'rails_helper'

describe 'Anyone' do
  scenario 'can navigate to the home page' do
    visit '/'

    expect(page).to have_css('#regions_div')
  end
end
