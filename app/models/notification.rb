class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :partner, class_name: 'User'
  belongs_to :emotion

  validates :user_id, :partner_id, :emotion_id, :status, presence: true
  enum status: { unread: 0, read: 1 } # ステータスの定義
end
