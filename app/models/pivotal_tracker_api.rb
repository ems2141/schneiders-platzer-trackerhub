require 'faraday'
require 'json'

class PivotalTrackerApi

  def initialize(token)
    @token = token
    @conn = Faraday.new(:url => 'https://www.pivotaltracker.com') do |faraday|
      faraday.request :url_encoded # form-encode POST params
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end
  end

  def list_projects
    conn = Faraday.new(:url => 'https://www.pivotaltracker.com') do |faraday|
      faraday.request :url_encoded # form-encode POST params
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end
    response = conn.get do |req|
      req.url '/services/v5/projects'
      req.headers['X-TrackerToken'] = @token
    end

    project_list =[]
    project_data = JSON.parse(response.body)
    project_data.each do |project|
      project_list << project['name']
    end
    project_list
  end

  def project_id_lookup(project_name)
    conn = Faraday.new(:url => 'https://www.pivotaltracker.com') do |faraday|
      faraday.request :url_encoded # form-encode POST params
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end
    response = conn.get do |req|
      req.url '/services/v5/projects'
      req.headers['X-TrackerToken'] = @token
    end

    project_data = JSON.parse(response.body)
    project_data.each do |project|
      if project["name"] == project_name
        return project["id"]
      end
    end
  end

  def list_stories(project_id)
    response = get(stories_url(project_id))

    stories = JSON.parse(response.body)
    stories.map { |story| {:id => story['id'], :name => story['name']} }
  end

  def list_stories_comments(project_id)
    stories_id_list = list_stories(project_id).map { |story| story[:id] }

    stories_id_list.map do |story_id|
      comments_for_story = get(stories_url(project_id) + "/#{story_id}?fields=comments").body
      JSON.parse(comments_for_story)['comments'].map do |comment|
        comment['text']
      end
    end.flatten
  end

  private
  def stories_url(project_id)
    "/services/v5/projects/#{project_id}/stories"
  end

  def get(url)
    @conn.get do |req|
      req.url url
      req.headers['X-TrackerToken'] = @token
    end
  end

end
