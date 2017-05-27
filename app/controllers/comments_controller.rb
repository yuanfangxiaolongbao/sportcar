class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @product = Product.find(params[:product_id])
    @comments = @product.comments.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @product = Product.find(params[:product_id])
    #binding.pry
    @comment = Comment.new
  end

  def create
    @product = Product.find(params[:product_id])
    @comment = Comment.new(commemt_params)
    @comment.user_id = current_user.id
    @comment.product = @product

    if @comment.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def index
    @product = Product.find(params[:product_id])
    @comments = @product.comments.order("created_at DESC")
  end

  private

  def commemt_params
    params.require(:comment).permit(:description)
  end
end
