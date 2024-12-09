class User < ApplicationRecord
  authenticates_with_sorcery!
  # ユーザー作成前に実行されるコールバックを設定
  before_create :generate_unique_id
  # ユーザー作成後に実行されるコールバックを設定
  after_create :assign_default_categories
  after_create :assign_default_message_templates

  has_many :emotions, dependent: :destroy
  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories
  has_many :emotion_messages, dependent: :destroy
  has_many :user_templates, dependent: :destroy
  has_many :message_templates, through: :user_templates
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  has_one :emotion_partner, dependent: :destroy
  mount_uploader :avatar, AvatarUploader
  has_many :sent_likes, foreign_key: :sender_id, class_name: 'Like', dependent: :destroy
  has_many :received_likes, foreign_key: :receiver_id, class_name: 'Like', dependent: :destroy
  has_many :liked_emotions, through: :sent_likes, source: :emotion
  has_one :user_state, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :sent_notifications, class_name: 'Notification', foreign_key: 'partner_id', dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  # パートナーの感情記録を取得するメソッド
  def partner_emotions
    partner_id = EmotionPartner.find_by(user_id: id)&.partner_id
    Emotion.where(user_id: partner_id)
  end

  # 称号を取得するメソッド
  def title
    case received_likes.count
    when 0..9
      'パートナー入門者'
    when 10..29
      '仲良しのパートナー'
    when 30..99
      '信頼のパートナー'
    when 100..499
      '理想のパートナー'
    else
      '永遠のパートナー'
    end
  end

  private

  # デフォルトカテゴリーをユーザーに割り当てるメソッド
  def assign_default_categories
    default_categories = %w[仕事 家事 趣味]
    default_categories.each do |category_name|
      category = Category.create(name: category_name)
      # UserCategoryを介してUserとCategoryを関連付ける
      user_categories.create(category:)
    end
  end

  # デフォルトメッセージテンプレートをユーザーに割り当てるメソッド
  def assign_default_message_templates
    default_messages = %w[
      良いことがあったから話を聞いて下さい
      酷く疲れたので１人時間下さい
      その他
    ]
    default_messages.each do |message|
      message_template = MessageTemplate.create(message:)
      # UserTemplateを作成してUserとMessageTemplateを関連付ける
      user_templates.create(message_template:)
    end
  end

  def generate_unique_id
    # 一意の8文字のIDを生成
    loop do
      self.unique_id = SecureRandom.hex(4).upcase
      break unless User.exists?(unique_id:)
    end
  end
end
