class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  enum category: [:travel, :health, :food, :beauty, :green, :technology, :music, :design, :art, :education, :psychology, :fashion, :photography, :culture, :politic, :history, :science, :movie, :sport]
  scope :recent, -> { order('updated_at desc').limit(10) }
  belongs_to :user
  validates :title, presence: true
end
