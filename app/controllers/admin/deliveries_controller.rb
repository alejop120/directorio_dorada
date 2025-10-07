module Admin
  class DeliveriesController < ApplicationController
    def index
      @deliveries = Delivery.all.order_by(created_at: :desc)
    end

    def update
      @delivery = Delivery.find(params[:id])

      if @delivery.update(admin_delivery_params)
        redirect_to admin_deliveries_path, notice: 'Domicilio actualizado exitosamente'
      else
        redirect_to admin_deliveries_path, alert: 'Error al actualizar el domicilio'
      end
    end

    private

    def admin_delivery_params
      params.require(:delivery).permit(:delivery_person, :status)
    end
  end
end
