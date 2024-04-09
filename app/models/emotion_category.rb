class EmotionCategory < ApplicationRecord
  belongs_to :emotion
  belongs_to :user_category
end
