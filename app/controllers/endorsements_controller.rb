class EndorsementsController < ApplicationController
  def create
    @review = review
    @review.endorsements.create
    render json: { new_endorsement_count: @review.endorsements.count }
  end

  private

  def review
    @review ||= Review.find(params[:review_id])
  end
end
