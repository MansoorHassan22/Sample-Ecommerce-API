class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    products = Product.all
    response = {products: ProductBlueprint.render_as_json(products) , count: products.count}
    json_response(response)
  end

  # GET /products/1
  def show
    response = {store: ProductBlueprint.render_as_json(@product)}
    json_response(response)
  end

  # POST /products
  def create
    product = Product.new(product_params)

    if product.save
      response = {product: ProductBlueprint.render_as_json(product)}
      json_response(response, :created)
    else
      json_response({errors: product.errors}, :unprocessable_entity)
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      response = {product: ProductBlueprint.render_as_json(@product)}
      json_response(response)
    else
      json_response({errors: @product.errors}, :unprocessable_entity)
    end
  end

  def price_check
    raise(ExceptionHandler::BadRequest, Message.missing_params) if params[:cart].blank?
    total = 0
    total_items = 0
    params[:cart].each do |item|
      product = Product.where(id: item[:product_id]).first
      total = total + (product.price * item[:quantity])
      total_items = total_items + item[:quantity]
    end

    json_response({total: total, total_items: total_items})
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    json_response(message: "Product deleted successfully")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit( :name, :code, :price, :store_id)
    end
end
