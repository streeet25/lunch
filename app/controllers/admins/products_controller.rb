class Admins::ProductsController <  Admins::BaseController
  before_action :find_product , only: [:edit, :update, :destroy]
  PER_PAGE = 10

  def index
    @products = Product.order(:category_id).page(params[:page]).per(params[:per_page] || PER_PAGE).includes(:category)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admins_products_path
      flash[:success] = 'Product was successfully created.'
    else
      render :new
      flash[:error] = 'Something goes wrong.'
    end
  end

  def edit
  end

  def update

    if @product.update(product_params)
      redirect_to admins_products_path
      flash[:success] = 'Product was successfully updated.'
    else
      render :edit
      flash[:error] = 'Something goes wrong.'
    end
  end

  def destroy
    @product.destroy
    redirect_to admins_products_path
    flash[:success] = 'Product was successfully destroyed.'
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :category_id)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
