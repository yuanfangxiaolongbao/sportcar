class WelcomeController < ApplicationController
  def index
    @products = Product.order('sale_quantity DESC').paginate(:page => params[:page], :per_page => 6)
    ##binding.pry
    @products_recommend = Product.order('created_at DESC').paginate(:page => params[:page], :per_page => 3)
  end
end
