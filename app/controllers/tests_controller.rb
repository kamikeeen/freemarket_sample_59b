class TestsController < ApplicationController
  def index
  @test = Test.new
  end

  def create
    @test = Test.create(test_params)

  end


  private

  def test_params
    params.require(:test).permit(:image)
  end
end
