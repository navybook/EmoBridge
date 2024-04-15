class EmotionPartner < ApplicationRecord
  belongs_to :user
  belongs_to :partner, class_name: 'User', foreign_key: 'partner_id'

  validates :user_id, presence: true
  validates :partner_id, presence: true
end
