class DishesController < ApplicationController
  before_action :authenticate_user!

  def new
    @dish = Dish.new
  end

  def create
    @dish = current_user.dishes.new(check_params)

    if @dish.save
      redirect_to root_path, notice: 'Dish has been added'
    else
      flash.now[:alert] = @dish.errors.full_messages.to_sentence
      render 'new'
    end
  end

  private

  def check_params
    params.require(:dish).permit(:name, :details, :public)
  end
end
