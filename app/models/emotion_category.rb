class EmotionCategory < ApplicationRecord
  belongs_to :emotion
  belongs_to :user_category
  has_one :category, through: :user_category
end
