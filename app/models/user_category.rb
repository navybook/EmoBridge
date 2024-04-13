class UserCategory < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :emotion_categories, dependent: :destroy
end
