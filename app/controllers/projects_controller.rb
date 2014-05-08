require 'dotenv-rails'
Dotenv.load

class ProjectsController < ApplicationController

  def index
    @pta = PivotalTrackerApi.new(ENV['PIVOTAL_TOKEN'])
  end

  def show
    @pta = PivotalTrackerApi.new(ENV['PIVOTAL_TOKEN'])
    @proj_id = params[:id]
  end

end
