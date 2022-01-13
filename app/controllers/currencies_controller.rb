class CurrenciesController < ApplicationController
  before_action :set_currency, only: [:show, :update, :destroy]

  # GET /currencies
  def index
    currencies = Currency.all
    response = {currencies: CurrencyBlueprint.render_as_json(currencies) , count: currencies.count}
    json_response(response)
  end

  # GET /currencies/1
  def show
    response = {currencies: CurrencyBlueprint.render_as_json(@currency)}
    json_response(response)
  end

  # POST /currencies
  def create
    currency = Currency.new(currency_params)

    if currency.save
      response = {currency: CurrencyBlueprint.render_as_json(currency)}
      json_response(response, :created)
    else
      json_response({errors: currency.errors}, :unprocessable_entity)
    end
  end

  # PATCH/PUT /currencies/1
  def update
    if @currency.update(currency_params)
      json_response({currency: @currency})
    else
      json_response({errors: @currency.errors}, :unprocessable_entity)
    end
  end

  # DELETE /currencies/1
  def destroy
    @currency.destroy
    json_response(message: "Currency deleted successfully")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_currency
      @currency = Currency.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def currency_params
      params.require(:currency).permit( :name, :code)
    end
end
