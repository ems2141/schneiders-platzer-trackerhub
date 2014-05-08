require 'spec_helper'

feature 'trackerhub' do
  scenario 'it allows users to view all tracker projects' do
    VCR.use_cassette('projects') do
      visit '/'
      click_on "View Projects"

      expect(page).to have_content "Luke Bartel"
      expect(page).to have_content "Schneiders and Platzer's TrackerHub"
    end
  end
end
