class Delivery
  include Mongoid::Document
  include Mongoid::Timestamps

  field :service_type, type: String
  field :phone, type: String
  field :address, type: String
  field :status, type: String, default: 'pending'
  field :delivery_person, type: String

  validates :service_type, presence: true
  validates :phone, presence: true
  validates :address, presence: true

  VALID_SERVICE_TYPES = ['medicamentos', 'comida', 'mercado', 'paquetes']
  VALID_STATUSES = ['pending', 'assigned', 'in_progress', 'delivered', 'cancelled']

  validates :service_type, inclusion: { in: VALID_SERVICE_TYPES }
  validates :status, inclusion: { in: VALID_STATUSES }
end
