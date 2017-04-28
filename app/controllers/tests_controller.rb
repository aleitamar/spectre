require 'image_processor'

class TestsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @test = Test.new
  end

  def update
    @test = Test.find(params[:id])
    if params[:test][:baseline] == 'true'
      @test.pass = true
      @test.save
      redirect_to project_suite_run_url(@test.run.suite.project, @test.run.suite, @test.run)
    end
  end

  def create
    ImageProcessor.crop(test_params[:screenshot].path, test_params[:crop_area]) if test_params[:crop_area]
    @test = find_or_create_test(test_params)
    ScreenshotComparison.new(@test, test_params[:screenshot])
    render json: @test.to_json
  end

  private

  def find_or_create_test(test_params)
    search_params = test_params.reject { |k,_| k.to_sym == :screenshot }
    test = Test.find_or_create_by(search_params)
    test.screenshot = test_params[:screenshot]
    test
  end

  def test_params
    params.require(:test).permit(:name, :browser, :size, :screenshot, :run_id, :source_url, :fuzz_level, :highlight_colour, :crop_area, :diff_threshold)
  end
end
