class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :destination, optional: true

  has_many :bookings, dependent: :destroy
  has_many :passengers, through: :bookings, source: :user
  has_many :ratings, dependent: :destroy

  enum :status, { open: 0, full: 1, completed: 2, cancelled: 3 }, default: :open

  validates :departure_date, presence: true
  validates :departure_location, presence: true
  validate :departure_date_cannot_be_in_past, on: :create
  validates :available_seats, presence: true, numericality: { greater_than: 0 }
  validates :price_per_seat, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :destination_name, presence: true
  validates :activity_type, presence: true, inclusion: { in: %w[climbing hiking] }

  scope :upcoming, -> { where("departure_date > ?", Time.current).order(departure_date: :asc) }
  scope :available, -> { where(status: :open).upcoming }

  def seats_remaining
    available_seats - bookings.where(status: :confirmed).sum(:seats_booked)
  end

  def driver
    user
  end

  # Helper methods to get destination info (supports both old and new style)
  def display_name
    destination_name.presence || destination&.name || "Unknown"
  end

  def display_address
    destination_address.presence || destination&.address || ""
  end

  def display_image_url
    destination&.image_url || default_activity_image
  end

  def default_activity_image
    if climbing?
      "https://images.unsplash.com/photo-1564769662533-4f00a87b4056?w=800&q=80"
    else
      "https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&q=80"
    end
  end

  def climbing?
    activity_type == "climbing" || destination&.climbing?
  end

  def hiking?
    activity_type == "hiking" || destination&.hiking?
  end

  private

  def departure_date_cannot_be_in_past
    if departure_date.present? && departure_date < Time.current
      errors.add(:departure_date, "can't be in the past")
    end
  end
end
