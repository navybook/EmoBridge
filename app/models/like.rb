class Like < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :emotion

  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :emotion_id, uniqueness: { scope: [:sender_id, :receiver_id] }
end
