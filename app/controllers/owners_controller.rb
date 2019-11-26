class OwnersController < ApplicationController
  def index
  end

  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      owner_log_in @owner
      flash[:success] = "ご登録ありがとうございます！"
      redirect_to @owner
    else
      render "new"
    end
  end

  def show
    @owner = Owner.find(params[:id])
  end

  private
    def owner_params
      params.require(:owner).permit(:name, :email, :password, :password_confirmation)
    end
end
