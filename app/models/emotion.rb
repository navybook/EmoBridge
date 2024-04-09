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
    laugh: 'fa-regular fa-face-laugh-beam',
    smile: 'fa-regular fa-face-smile-beam',
    grin: 'fa-regular fa-face-grin-wide',
    tired: 'fa-regular fa-face-tired',
    dizzy: 'fa-regular fa-face-dizzy'
  }

  before_save :set_feeling_score

  def set_feeling_score
    feeling_scores = {
      laugh: 3,
      smile: 1,
      grin: 0,
      tired: -1,
      dizzy: -3
    }

    self.feeling_score = feeling_scores[feeling.to_sym]
  end
end
