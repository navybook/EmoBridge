class Category < ApplicationRecord
  has_many :user_categories, dependent: :destroy
  has_many :users, through: :user_categories
  has_many :emotion_categories, dependent: :destroy
  has_many :emotions, through: :emotion_categories
end
