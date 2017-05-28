class ProductsController < ApplicationController
  before_action :validate_search_key, only: [:search_word]

  def index
    #@products = Product.all
    #按照是否需要分类查找区分
    if params[:category].blank?
      @products = case params[:order]
                  when 'by_lower_price'
                    Product.order('price')
                  when 'by_upper_price'
                    Product.order('price DESC')
                  when 'by_upper_sale_quantity'
                    Product.order('sale_quantity DESC')
                  else
                    Product.order('created_at DESC')
                  end
    else
      @category_id = Category.find_by(name: params[:category]).id
      @products = Product.where(category_id: @category_id)
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你成功加入购物车"
    else
      flash[:warning] = "购物车已有此商品"
    end
    redirect_to :back
    #flash[:notice] = "test"
  end

  def search_word
    if @query_string.present?
      search_result = Product.ransack(@search_criteria).result(:distinct => true)
      @products = search_result.paginate(:page => params[:page], :per_page => 5)
    end
  end

  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end

  def search_criteria(query_string)
    { :title_cont => query_string }
  end

end
