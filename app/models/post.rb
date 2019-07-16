class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_one_attached :post_thumbnails

  enum category: [:travel, :health, :food_n_drink, :beauty, :green, :technology, :music, :design, :art, :education, :psychology, :fashion, :photography, :culture, :politic, :history, :science, :movie, :sport]
  scope :recent, -> { order('updated_at desc').limit(10) }
  belongs_to :user
  validates :title, presence: true

  def thumb_url
    Rails.application.routes.url_helpers.rails_representation_url(post_thumbnails.variant(resize: "100x100").processed, only_path: true) if post_thumbnails.attached?
  end
end
