class Delivery
  include Mongoid::Document
  include Mongoid::Timestamps

  field :service_type, type: String
  field :phone, type: String
  field :address, type: String
  field :status, type: String, default: 'pending'
  field :delivery_person, type: String
  field :price, type: Integer
  field :requested_at, type: Time

  validates :service_type, presence: true
  validates :phone, presence: true
  validates :address, presence: true

  VALID_SERVICE_TYPES = ['medicamentos', 'comida', 'mercado', 'paquetes']
  VALID_STATUSES = ['pending', 'assigned', 'in_progress', 'delivered', 'cancelled']
  BASE_PRICE = 3000
  NIGHT_SURCHARGE = 1000
  SERVICE_START_HOUR = 7
  SERVICE_END_HOUR = 24
  NIGHT_RATE_START_HOUR = 18

  validates :service_type, inclusion: { in: VALID_SERVICE_TYPES }
  validates :status, inclusion: { in: VALID_STATUSES }
  validate :validate_service_hours

  before_validation :set_requested_at, on: :create
  before_validation :calculate_price, on: :create

  def calculate_price
    return unless requested_at

    hour = requested_at.hour
    self.price = if hour >= NIGHT_RATE_START_HOUR || hour < SERVICE_START_HOUR
      BASE_PRICE + NIGHT_SURCHARGE
    else
      BASE_PRICE
    end
  end

  def validate_service_hours
    return unless requested_at

    hour = requested_at.hour
    if hour < SERVICE_START_HOUR && hour >= SERVICE_END_HOUR
      errors.add(:base, "El servicio solo está disponible de 7:00 AM a 12:00 AM (medianoche)")
    end
  end

  private

  def set_requested_at
    self.requested_at ||= Time.current
  end
end
