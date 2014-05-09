require 'spec_helper'

feature 'trackerhub' do
  scenario 'it allows users to view all tracker projects' do
    VCR.use_cassette('tracker/projects') do
      visit '/'
      click_on "View Projects"

      expect(page).to have_content "Luke Bartel"
      expect(page).to have_content "Schneiders and Platzer's TrackerHub"
    end
  end
  scenario 'User can view all the stories in a project' do
    VCR.use_cassette('tracker/stories') do
      visit '/projects'
      click_on "Schneiders and Platzer's TrackerHub"
      expect(page).to have_content "As a user, I can view all of the stories for a project"
      expect(page).to have_content "As a user, I can post a new GitHub comment for the a tracker commit comment (basic auth)"
    end
  end

  scenario 'As a user, I can view Tracker comments for a project' do
    VCR.use_cassette('tracker/comments') do
      visit '/projects'
      click_on "Schneiders and Platzer's TrackerHub"
      expect(page).to have_content "This is a comment on the comment story"
      expect(page).to have_content "This is a test comment on the first story"
    end
  end
end
