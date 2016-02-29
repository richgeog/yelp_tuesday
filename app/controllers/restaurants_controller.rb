class RestaurantsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @user = user
    @restaurant = Restaurant.new
  end

  def create
    @user = user
    create_new_restaurant
  end

  def show
    @restaurant = restaurant
  end

  def edit
    @restaurant = restaurant
    user_not_restaurant_creator
  end

  def update
    @restaurant = restaurant
    @restaurant.update(restaurant_params)
    redirect_to restaurants_path
  end

  def destroy
    @restaurant = restaurant
    @restaurant.destroy
    flash[:notice] = 'Restaurant deleted successfully'
    redirect_to restaurants_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :image)
  end

  def user
    @_user ||= User.find(current_user.id)
  end

  def restaurant
    @_restaurant ||= Restaurant.find(params[:id])
  end

  def user_not_restaurant_creator
    return if current_user.id == @restaurant.user_id
    flash[:notice] = 'Unable to edit as not the creator'
    redirect_to restaurants_path
  end

  def create_new_restaurant
    @restaurant = @user.restaurants.create(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end
end
