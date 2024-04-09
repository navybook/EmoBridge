class EmotionMessage < ApplicationRecord
  belongs_to :user
  belongs_to :emotion
  belongs_to :user_template
end
