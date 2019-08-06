class Post < ApplicationRecord
  include Elasticsearchable
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_one_attached :post_thumbnails

  enum category: [:travel, :health, :food, :beauty, :green, :technology, :music, :design, :art, :education, :psychology, :fashion, :photography, :culture, :politic, :history, :science, :movie, :lifestyle, :sport, :freelance, :wildlife, :seo, :zodiac]
  scope :recent, -> { order('updated_at desc').limit(100) }
  belongs_to :user
  validates :title, presence: true
  index_name { 'post_repository_v1' }
  document_type { 'post_repository_v1' }

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


  def as_indexed_json(options={})
    as_json(only: [:title, :description])
  end
  def self.elasticsearch_import(force: false, refresh: false)
      import query: -> {
                      includes(:user)
                    },
             force: force,
             refresh: refresh,
             batch_size: 1000
    end

    def self.search(query)

      return current_elasticsearch_repository.search({
        query: {
          match_all: {

          }
        }

      }) unless query

      current_elasticsearch_repository.search({
        query: {
          query_string: {
            query: query
          }
        }

      })
    end
    def self.elasticsearch_repositories
      @elasticsearch_repositories ||= [
        PostRepositoryV1.new
      ]
    end

    def self.current_elasticsearch_repository
      current_elasticsearch_repository_class.new
    end

    def self.current_elasticsearch_repository_class
      PostRepositoryV1
    end

    def self.bulk_import(repositories: nil, batch_size: 1000)

      repositories = repositories.empty? ? Post.elasticsearch_repositories : repositories
      Post.find_in_batches(batch_size: batch_size) do |posts|
        repositories.each do |repository|

          posts.each { |post| repository.save(post) }
        end
      end
    end
end
