class Rating < ApplicationRecord
  belongs_to :trip
  belongs_to :reviewer, class_name: "User"
  belongs_to :rated_user, class_name: "User"

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :trip_id, uniqueness: { scope: [:reviewer_id, :rated_user_id], message: "already rated" }

  # Can't rate yourself
  validate :cannot_rate_self

  private

  def cannot_rate_self
    if reviewer_id == rated_user_id
      errors.add(:rated_user, "can't rate yourself")
    end
  end
end
