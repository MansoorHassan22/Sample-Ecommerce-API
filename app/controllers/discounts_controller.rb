class DiscountsController < ApplicationController
  before_action :set_discount, only: [:show, :update, :destroy, :add_products]

  # GET /discounts
  def index
    discounts = Discount.all
    response = {discounts: DiscountBlueprint.render_as_json(discounts) , count: discounts.count}
    json_response(response)
  end

  # GET /discounts/1
  def show
    response = {discount: DiscountBlueprint.render_as_json(@discount, view: :detail)}
    json_response(response)
  end

  # POST /discounts
  def create
    discount = Discount.new(discount_params)

    if discount.save
      if params[:product_ids].present?
        products = Product.where(id:  params[:product_ids]).all
        discount.products << products
      end
      response = {discount: DiscountBlueprint.render_as_json(discount)}
      json_response(response, :created)
    else
      json_response({errors: discount.errors}, :unprocessable_entity)
    end
  end

  # PATCH/PUT /discounts/1
  def update
    if @discount.update(discount_params)
      if params[:product_ids].present?
        new_ids = params[:product_ids] - @discount.products.pluck(:id)
        products = Product.where(id:  new_ids).all
        @discount.products << products
      end
      response = {discount: DiscountBlueprint.render_as_json(@discount)}
      json_response(response)
    else
      json_response({errors: discount.errors}, :unprocessable_entity)
    end
  end

  def add_products
    if params[:product_ids].present?
      new_ids = params[:product_ids] - @discount.products.pluck(:id)
      products = Product.where(id:  new_ids).all
      @discount.products << products
    end
    response = {discount: DiscountBlueprint.render_as_json(@discount, view: :detail)}
    json_response(response)
  end

  # DELETE /discounts/1
  def destroy
    @discount.destroy
    json_response(message: "Discount deleted successfully")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discount
      @discount = Discount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def discount_params
      params.require(:discount).permit( :name, :is_percentage_type, :is_product_type, :minimum_products, :maximum_products, :free_products, :percentage)
    end
end
