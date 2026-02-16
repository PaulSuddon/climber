class Conversation < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  has_many :messages, dependent: :destroy

  validates :sender_id, uniqueness: { scope: :recipient_id }

  scope :involving, ->(user) {
    where("sender_id = ? OR recipient_id = ?", user.id, user.id)
  }

  scope :between, ->(sender_id, recipient_id) {
    where("(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)",
          sender_id, recipient_id, recipient_id, sender_id)
  }

  def other_party(user)
    user == sender ? recipient : sender
  end

  def unread_messages_for(user)
    messages.where.not(user: user).where(read: false)
  end

  def last_message
    messages.order(created_at: :desc).first
  end
end
