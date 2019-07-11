class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  scope :recent, -> { order('updated_at desc').limit(10) }
  belongs_to :user
  validates :title, presence: true
end
