class Post < ApplicationRecord
  scope :recent, -> { order('updated_at desc').limit(10) }
  belongs_to :user
  validates :title, presence: true
end
