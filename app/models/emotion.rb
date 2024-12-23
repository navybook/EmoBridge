class Emotion < ApplicationRecord
  belongs_to :user
  has_many :emotion_categories, dependent: :destroy
  has_many :user_categories, through: :emotion_categories
  has_one :emotion_message, dependent: :destroy
  has_many :user_templates, through: :emotion_message
  has_many :likes, dependent: :destroy
  has_many :liking_senders, through: :likes, source: :sender
  has_many :notifications, dependent: :destroy

  validates :feeling, presence: true

  before_save :set_feeling_score
  after_create :create_notification

  # accepts_nested_attributes_forの追加
  accepts_nested_attributes_for :emotion_message, :emotion_categories

  # feeling属性のenum設定
  enum feeling: {
    happy: 'fa-regular fa-face-laugh-beam',
    normal: 'fa-regular fa-face-grin-wide',
    tired: 'fa-regular fa-face-tired',
    sad: 'fa-regular fa-face-sad-tear',
    angry: 'fa-regular fa-face-angry'
  }

  private

  def set_feeling_score
    feeling_scores = {
      happy: 3,
      normal: 0,
      tired: -1,
      sad: -2,
      angry: -3
    }

    self.feeling_score = feeling_scores[feeling.to_sym]
  end

  def create_notification
    partner = EmotionPartner.find_by(user_id:)
    return unless partner # パートナーがいない場合は処理を中断

    Notification.create(
      user_id:,
      partner_id: partner.partner_id,
      emotion_id: id,
      status: 0
    )
  end
end
