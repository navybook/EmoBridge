class EmotionMessage < ApplicationRecord
  belongs_to :user
  belongs_to :emotion
  belongs_to :user_template
  has_one :message_template, through: :user_template
end
