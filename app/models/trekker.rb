class Trekker < ApplicationRecord
  include Elasticsearchable
  include Geoable

  enum role: [:photographer, :tour_guide, :dive_master, :cook, :diver, :trekker]
  belongs_to :user

  def self.update_repository(document)
    current_elasticsearch_repository.save(document)
  end

  def self.elasticsearch_import(force: false, refresh: false)
    import(
      force: force,
      refresh: refresh,
      batch_size: 1000
    )
  end

  def self.search(query, query_size=5, page=1)
    from = page*query_size - query_size
    condition = {
      query: {
        match_all: {}
      },
      sort: [
        { updated_at: { order: "desc"} }
      ],
      from: from,
      size: query_size
    }

    return current_elasticsearch_repository.search(condition) unless query
    condition[:query] = {
      query_string: {
        query: query
      }
    }

    current_elasticsearch_repository.search(condition)
  end

  def self.elasticsearch_repositories
    @elasticsearch_repositories ||= [
      TrekkerRepositoryV1.new
    ]
  end

  def self.current_elasticsearch_repository
    @repository ||= current_elasticsearch_repository_class.new
  end

  def self.current_elasticsearch_repository_class
    TrekkerRepositoryV1
  end

  def self.bulk_import(repositories: nil, batch_size: 1000)
    repositories = repositories.empty? ? Trekker.elasticsearch_repositories : repositories
    Trekker.find_in_batches(batch_size: batch_size) do |posts|
      repositories.each do |repository|
        posts.each { |post| repository.save(post) }
      end
    end
  end
end
