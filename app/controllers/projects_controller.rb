require 'dotenv-rails'
Dotenv.load

class ProjectsController < ApplicationController

  def index
    @pta = PivotalTrackerApi.new(ENV['PIVOTAL_TOKEN'])
    # @pta.list_projects
  end

end
