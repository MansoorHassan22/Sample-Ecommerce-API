class StoresController < ApplicationController
  before_action :set_store, only: [:show, :update, :destroy]

  # GET /stores
  def index
    stores = Store.all
    response = {stores: StoreBlueprint.render_as_json(stores) , count: stores.count}
    json_response(response)
  end

  # GET /stores/1
  def show
    response = {store: StoreBlueprint.render_as_json(@store, view: :detail)}
    json_response(response)
  end

  # POST /stores
  def create
    store = Store.new(store_params)

    if store.save
      response = {store: StoreBlueprint.render_as_json(store)}
      json_response(response, :created)
    else
      json_response({errors: store.errors}, :unprocessable_entity)
    end
  end

  # PATCH/PUT /stores/1
  def update
    if @store.update(store_params)
      response = {store: StoreBlueprint.render_as_json(@store)}
      json_response(response)
    else
      json_response({errors: @store.errors}, :unprocessable_entity)
    end
  end

  # DELETE /stores/1
  def destroy
    @store.destroy
    json_response(message: "Store deleted successfully")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def store_params
      params.require(:store).permit( :name, :currency_id)
    end
end
