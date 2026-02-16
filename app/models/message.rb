class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: true

  scope :unread, -> { where(read: false) }
  scope :recent_first, -> { order(created_at: :desc) }

  after_create_commit :update_conversation_timestamp

  private

  def update_conversation_timestamp
    conversation.touch
  end
end
