class DishesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_available_dishes, except: %i[new create]
  before_action :set_dish, only: %i[show edit update]

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

  def index
    @dishes = Dish.all
  end

  private

  def check_params
    params.require(:dish).permit(:name, :details, :public)
  end

  def set_available_dishes
    @dishes = Dish.public_or_own_dishes(current_user).all
  end

  def set_dish
    @dish = Dish.find(params[:id])
    render file: Rails.root.join('public', '404.html'), status: :not_found if @dish.blank?
  end
end
