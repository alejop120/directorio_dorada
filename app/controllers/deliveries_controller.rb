class DeliveriesController < ApplicationController
  def index
    @deliveries = Delivery.all
  end

  def new
    @delivery = Delivery.new
  end

  def create
    @delivery = Delivery.new(delivery_params)

    if @delivery.save
      redirect_to delivery_path(@delivery), notice: 'Solicitud creada exitosamente'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @delivery = Delivery.find(params[:id])
  end

  private

  def delivery_params
    params.require(:delivery).permit(:service_type, :phone, :address)
  end
end
