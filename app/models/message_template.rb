class MessageTemplate < ApplicationRecord
  has_many :user_templates, dependent: :destroy
  has_many :users, through: :user_templates

  validates :message, presence: true
end
