module Admin
  class ProductsController < Admin::BaseController

    crudify :product,
            :title_attribute => 'name', :xhr_paging => true
            
    def index
      if params[:category_id].present?    
        @category = Category.find(params[:category_id])
        @products = Product.by_category(@category.id).order('position ASC').paginate(:page => params[:page])
      else 
        paginate_all_products
      end
    end
    
    def update_prices
      Product.update(params[:products].keys, params[:products].values)
      flash[:notice] = 'Prices were successfully updated.'
      redirect_to :action => "index"
    end

  end
end
