class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_one_attached :post_thumbnails

  enum category: [:travel, :health, :food, :beauty, :green, :technology, :music, :design, :art, :education, :psychology, :fashion, :photography, :culture, :politic, :history, :science, :movie, :lifestyle, :sport, :freelance, :wildlife, :seo, :zodiac]
  scope :recent, -> { order('updated_at desc').limit(10) }
  belongs_to :user
  validates :title, presence: true

  def thumb_url
    Rails.application.routes.url_helpers.rails_representation_url(post_thumbnails.variant(
      combine_options: [
        [:resize, "250x250^"],
        [:gravity, "center"],
        [:crop, "250x250+0+0"],
        [:strip, true],
        [:quality, "70"],
        [:repage, nil], [:+, nil], # +repage
        [:distort, nil], [:+, "Perspective"]
      ]
    ).processed, only_path: true) if post_thumbnails.attached?
  end
end
