class MenuItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_avaiable_dish, only: %i[new create edit update]
  before_action :fetch_days_and_meals, except: :destroy
  before_action :fetch_menu_item, only: %i[destroy edit update]

  def new
    @menu_item = MenuItem.new
  end

  def create
    @menu_item = current_user.menu_items.new(check_params)
    @menu_item.dish = @dish
    if @menu_item.save
      redirect_to menu_path,
      notice: 'Dish has been added to Menu'
    else
      flash.now[:alert] = "Ooops, sth's gone wrong"
      render 'new'
    end
  end

  def index
    @menu_items = MenuItem.where(user: current_user)
    @grouped_menu_items = MenuItem.all.includes(:dish).group_by { |item| [item.day, item.meal] }
  end

  def destroy
    @menu_item.destroy
    redirect_to menu_path
  end

  def edit; end

  def update
    if @menu_item.update(check_params)
      redirect_to menu_path,
      notice: 'Dish has been moved in Menu'
    else
      flash.now[:alert] = "Ooops, sth's gone wrong"
      render 'new'
    end
  end

  private

  def check_params
    params.require(:menu_item).permit(:day, :meal)
  end

  def fetch_days_and_meals
    @days = MenuItem::DAYS
    @meals = MenuItem::MEALS
  end

  def set_avaiable_dish
    @dish = Dish.own(current_user).find(params[:dish_id])
  end

  def fetch_menu_item
    @menu_item = MenuItem.find(params[:id])
  end
end
