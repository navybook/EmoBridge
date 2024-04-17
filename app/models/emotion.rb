class Emotion < ApplicationRecord
  belongs_to :user
  validates :feeling, presence: true
  has_many :emotion_categories, dependent: :destroy
  has_many :user_categories, through: :emotion_categories
  has_one :emotion_message, dependent: :destroy
  has_many :user_templates, through: :emotion_message

  # accepts_nested_attributes_forの追加
  accepts_nested_attributes_for :emotion_message, :emotion_categories

  # feeling属性のenum設定
  enum feeling: {
    happy: 'fa-regular fa-face-laugh-beam',
    smile: 'fa-regular fa-face-smile-beam',
    normal: 'fa-regular fa-face-grin-wide',
    tired: 'fa-regular fa-face-tired',
    exhausted: 'fa-regular fa-face-dizzy'
  }

  before_save :set_feeling_score

  def set_feeling_score
    feeling_scores = {
      happy: 3,
      smile: 1,
      normal: 0,
      tired: -1,
      exhausted: -3
    }

    self.feeling_score = feeling_scores[feeling.to_sym]
  end
end
