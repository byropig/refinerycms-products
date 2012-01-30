class ProductsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_filter :find_all_products, :only => :index
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @product in the line below:
    present(@page)
  end

  def show
    @product = Product.find(params[:id])

    
    @tagged_products = Product.tagged_with(@product.tag_list, :any => :true).order('position ASC')
    
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @product in the line below:
    present(@page)
  end

  def get_variant_image
    if params[:variant_id].present?
      variant_url = Variant.find(params[:variant_id]).image.url
    end
    render :text => variant_url    
  end
  
  def get_variant_price
    if params[:variant_id].present?
      variant_price = Variant.find(params[:variant_id]).price
    end
    render :text => number_to_currency(variant_price, :unit => 'R')   
  end
  
protected

  def find_all_products
    
    if params[:category_id].present?      
      @category = Category.find(params[:category_id])
      @products = Product.by_category(@category.id).order('position ASC')
      @page_title = @category.name      
    else
      if params[:upper].present? and params[:lower].present?
        @products = Product.greater_than(params[:lower]).less_than(params[:upper])
        @page_title = "By Price"
      elsif params[:tag].present? 
        @products = Product.tagged_with(params[:tag]).order('position ASC')
        @page_title = params[:tag].capitalize
      end  
    end
  end

  def find_page
    @page = Page.where(:link_url => "/products").first
  end

end
