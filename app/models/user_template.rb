class UserTemplate < ApplicationRecord
  belongs_to :user
  belongs_to :message_template
  has_many :emotion_messages, dependent: :destroy
  has_one :emotion, through: :emotion_messages
end
