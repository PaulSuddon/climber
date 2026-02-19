class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :trips, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :booked_trips, through: :bookings, source: :trip
  has_many :notifications, dependent: :destroy

  has_many :sent_conversations, class_name: "Conversation", foreign_key: :sender_id, dependent: :destroy
  has_many :received_conversations, class_name: "Conversation", foreign_key: :recipient_id, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_many :ratings_given, class_name: "Rating", foreign_key: :reviewer_id, dependent: :destroy
  has_many :ratings_received, class_name: "Rating", foreign_key: :rated_user_id, dependent: :destroy

  validates :name, presence: true

  def conversations
    Conversation.involving(self).order(updated_at: :desc)
  end

  def unread_messages_count
    Message.joins(:conversation)
           .where("conversations.sender_id = ? OR conversations.recipient_id = ?", id, id)
           .where.not(user_id: id)
           .where(read: false)
           .count
  end

  def unread_notifications_count
    notifications.unread.count
  end

  def completed_trips_count
    # Trips where user was a passenger and the trip is completed
    bookings.joins(:trip).where(trips: { status: :completed }, status: :confirmed).count
  end

  def trips_as_driver_count
    trips.where(status: :completed).count
  end

  def total_adventures_count
    completed_trips_count + trips_as_driver_count
  end

  def avatar_url
    if avatar.attached?
      avatar
    else
      nil
    end
  end

  def average_rating
    ratings_received.average(:rating)&.round(1)
  end

  def ratings_count
    ratings_received.count
  end
end
