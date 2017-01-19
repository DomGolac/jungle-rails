class ReviewsController < ApplicationController

  before_filter :authorize

  def create
    product = Product.find params[:product_id]
    current_user ||= User.find(session[:user_id]) if session[:user_id]
    @review = Review.new(review_params)
    
    if current_user
      @review.product_id = product.id
      @review.user_id = current_user.id
      if @review.valid?
        @review.save!
      end
    end
    
    redirect_to product
  end

  def destroy
    review = Review.find params[:id]
    puts review.inspect
    review.destroy!
    redirect_to product_path(params[:product_id])
  end

  private

  def review_params
    params[:product].require(:reviews).permit(:description, :rating, :product_id)
  end

end
