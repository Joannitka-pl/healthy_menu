class DishesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_visible_dishes, only: %i[show index clone]
  before_action :set_avaiable_dishes, only: %i[edit update destroy]
  before_action :fetch_dish, only: %i[show clone]

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

  def edit; end

  def update
    if @dish.update(check_params)
      redirect_to dish_path, notice: 'Dish has been changed'
    else
      flash.now[:alert] = @dish.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def show; end

  def index; end

  def destroy
    @dish.destroy
    redirect_to dishes_path
  end

  def clone
    @dish = Dish.new(
      user: current_user,
      name: "#{@dish.name} of #{current_user.nick}",
      details: @dish.details,
      public: false
    )
    if @dish.save
      redirect_to dish_path(@dish), notice: 'Dish has been cloned'
    else
      flash.now[:alert] = @dish.errors.full_messages.to_sentence
      render 'show'
    end
  end

  private

  def check_params
    params.require(:dish).permit(:name, :details, :public)
  end

  def set_visible_dishes
    @dishes = Dish.public_or_own_dishes(current_user).all
  end

  def set_avaiable_dishes
    @dish = Dish.own_dishes(current_user).find(params[:id])
  end

  def fetch_dish
    @dish = @dishes.find(params[:id])
  end
end
