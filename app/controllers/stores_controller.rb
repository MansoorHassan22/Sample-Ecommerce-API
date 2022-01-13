class StoresController < ApplicationController
  before_action :set_store, only: [:show, :update, :destroy]

  # GET /stores
  def index
    stores = Store.all
    json_response({stores: stores})
  end

  # GET /stores/1
  def show
    json_response({store: @store})
  end

  # POST /stores
  def create
    store = Store.new(store_params)

    if store.save
      json_response({store: store}, :created)
    else
      json_response({errors: store.errors}, :unprocessable_entity)
    end
  end

  # PATCH/PUT /stores/1
  def update
    if @store.update(store_params)
      json_response({store: @store})
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
