class ReviewsController < ApplicationController
  def new
    @restaurant = restaurant
    @review = Review.new
  end

  def create
    @restaurant = restaurant
    @review = @restaurant.reviews.build_with_user(review_params, current_user)
    if @review.save
      redirect_to restaurants_path
    else
      check_user_reviewed
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to restaurants_path
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

  def restaurant
    @_restaurant ||= Restaurant.find(params[:restaurant_id])
  end

  def check_user_reviewed
    if @review.errors[:user]
      redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
    else
      render :new
    end
  end
end
