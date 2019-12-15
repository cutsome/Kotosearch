class LeisuresController < ApplicationController
  def show
    @leisure = Leisure.find(params[:id])
  end
end
