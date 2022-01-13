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
    currency_code = 'EUR'
    params[:cart].each do |item|
      product = Product.where(id: item[:product_id]).first
      if product.present?
        currency_code = product.store.currency.code
        total = total + (product.price * item[:quantity])
        total_items = total_items + item[:quantity]
      end
    end

    json_response({total: total, total_with_sysmbol: Money.from_amount(total, currency_code).format, total_items: total_items})
  end

  def price_check_with_discount
    raise(ExceptionHandler::BadRequest, Message.missing_params) if params[:cart].blank?
    total = 0
    total_items = 0
    response = {}
    currency_code = 'EUR'
    params[:cart].each do |item|
      product = Product.where(id: item[:product_id].to_i).first
      if product.present?
        discount = product.discounts.first
        currency_code = product.store.currency.code
        if discount.present? && discount.is_product_type
          response = calculate_product_type_discounted_total product, item, discount
        elsif discount.present? && discount.is_percentage_type
          response = calculate_percentage_type_discounted_total product, item, discount
        else
          response = calculate_product_total product, item
        end
        total = total + response[:total]
        total_items = total_items + response[:total_items]
      end
    end

    json_response({total: total, total_with_sysmbol: Money.from_amount(total, currency_code).format , total_items: total_items})
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

    def calculate_product_total total = 0, total_items = 0, product, item
      total = total + (product.price * item[:quantity])
      total_items = total_items + item[:quantity]
      return {total: total, total_items: total_items}
    end

    def calculate_product_type_discounted_total total = 0, total_items = 0, product, item, discount
      check_discount_allowed = item[:quantity].to_i >= discount.minimum_products
      paid_products_quantity = item[:quantity]
      if check_discount_allowed
        paid_products_quantity = discount.maximum_products != 0 ? ((item[:quantity].to_i - discount.maximum_products) / discount.minimum_products) : (item[:quantity].to_i  / discount.minimum_products)
        if discount.maximum_products != 0
          paid_products_quantity = item[:quantity] - discount.free_products
        else
          paid_products_quantity = (item[:quantity].to_i  / discount.minimum_products)
          paid_products_quantity = paid_products_quantity + (item[:quantity].to_i % discount.minimum_products)
        end
      end
      total = total + (product.price * paid_products_quantity)
      total_items = total_items + item[:quantity].to_i
      return {total: total, total_items: total_items}
    end

    def calculate_percentage_type_discounted_total total = 0, total_items = 0, product, item, discount
      check_discount_allowed = item[:quantity].to_i >= discount.minimum_products
      discounted_price = product.price
      discounted_products_quantity = 0
      discounted_total = 0
      if check_discount_allowed
        discounted_products_quantity = discount.maximum_products != 0 ? (item[:quantity].to_i - discount.maximum_products / discount.minimum_products) : (item[:quantity].to_i)
        discounted_price = product.price - ((product.price * discount.percentage) /100)
        discounted_total = (discounted_price * discounted_products_quantity)
      end
      total = discounted_total + (product.price * (item[:quantity] - discounted_products_quantity))
      total_items = total_items + item[:quantity].to_i
      return {total: total, total_items: total_items}
    end
end
