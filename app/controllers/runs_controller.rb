class RunsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :logged_in_using_omniauth?, only: [:create, :new]

  def show
    project = Project.find_by_slug!(params[:project_slug])
    suite = project.suites.find_by_slug!(params[:suite_slug])
    @run = suite.runs.find_by_sequential_id!(params[:sequential_id])
    @test_filters = TestFilters.new(@run.tests, true, params)

    respond_to do |format|
      format.html
      format.json {
        render json: @run.to_json(:include => :tests)
      }
    end
  end

  def new
    @run = Run.new
  end

  def create
    project = Project.find_or_create_by(name: params[:project])
    suite = project.suites.find_or_create_by(name: params[:suite])
    @run = if params[:external_id]
      suite.runs.find_or_create_by(external_id: params[:external_id])
    else
      suite.runs.create
    end
    render :json => @run.to_json
  end
end
