class TargetsController < ApplicationController
  def show
    @target = Target.find(params[:id])
  end
end
