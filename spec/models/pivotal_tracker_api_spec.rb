require 'spec_helper'

describe PivotalTrackerApi do

  before do
    @project_id = 1075502
    @tracker = PivotalTrackerApi.new(ENV['PIVOTAL_TOKEN'])
  end

  it 'can get a list of stories' do
    expected_stories = [
      {name: "Some name", id: 1234}
    ]

    VCR.use_cassette("stories/project#{@project_id}") do
      expect(@tracker.list_stories(@project_id)).to eq expected_stories
    end
  end

  it 'can get a list of comments for a project' do
    expected_comments = [
      "This is a test comment on the first story",
      "This is a second test comment on the first story",
      "Commit by Ellie Schneiders\nhttps://github.com/ems2141/schneiders-platzer-trackerhub/commit/109540f5e6b025873c04d0b024486f59ad249b42\n\n[#70885510] Initial Commit\n\nTesting webhooks",
      "Commit by EmilyPlatzer\nhttps://github.com/ems2141/schneiders-platzer-trackerhub/commit/4009b54919a2f808a286aa4b8a0b16df8c0e8932\n\n[#70885510] As a user, I can view all of my projects",
      "No staging heroku\n",
      "Commit by Emily Platzer\nhttps://github.com/ems2141/schneiders-platzer-trackerhub/commit/53f5fedae4cd5ecee131d6da1bf72d1aac07c533\n\n[#70885512] User can view all stories for a particular project\n\nSigned-off-by: Ellie Schneiders <ems2141@gmail.com>",
      "No staging heroku",
      'No title "Stories". Please look at the mocks',
      "This is a comment on the comment story"
    ]

    VCR.use_cassette("comments/project#{@project_id}") do
      expect(@tracker.list_stories_comments(@project_id)).to eq expected_comments
    end
  end

end
