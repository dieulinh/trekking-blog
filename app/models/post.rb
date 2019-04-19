class Post < ApplicationRecord
  scope :recent, -> { order('updated_at desc').limit(10) }
end