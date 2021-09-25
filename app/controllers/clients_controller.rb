class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: %i[ show update destroy ]

  def index
    @clients = current_user.clients
  end

  def show
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      render :show, status: :created
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def update
    if @client.update(client_params)
      render :show, status: :ok
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def client_params
    defaults = { user_clients_attributes: [{ client: @client.presence, user: current_user }] }
    params.require(:client).permit(:name, :email, :password, :phone, :uuid, :client_id,
                                   :access_token, :refresh_token).reverse_merge(defaults)
  end
end
