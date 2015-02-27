class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category).all
  end

  def show
    @selected_product = Product.find(params[:id])
    @product_comments = Comment.where("product_id = #{params[:id]}")
    render 'products/show'
  end

  def new
    render 'products/new'
  end

  def edit
    @product_to_edit = Product.find(params[:id])
    render 'products/edit'
  end

  def create
    @product = Product.new(product_params)
    @create = @product.save
    redirect_to root_path, notice: "You've successfully added a new product, #{@product.name}"
  end

  def update
    @product = Product.find(params[:id]).update(product_params)
    redirect_to root_path, notice: "#{product_params['name']} has been updated."
  end

  def destroy
    @product = Product.find(params[:id]).delete
    redirect_to root_path, notice: "#{@product.name} has been deleted"
  end

private
  def product_params
    params.require(:product).permit(:name, :description, :pricing, :category_id)
  end

end
