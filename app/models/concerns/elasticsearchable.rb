# frozen_string_literal: true

module Elasticsearchable
  extend ActiveSupport::Concern

  included do |_base|
    include Elasticsearch::Model

    # include Elasticsearch::Model::Callbacks

    # Customize the index name
    #
    # index_name [Rails.application.engine_name, Rails.env, name].map(&:downcase).join('_').gsub!('::', '__')

    def self.bulk_import(repositories: nil, batch_size: 1000)
      raise NotImplementedError, "You must implement #{self.class}##{__method__}"
    end

    def self.elasticsearch_repositories
      raise NotImplementedError, "You must implement #{self.class}##{__method__}"
    end

    def self.current_elasticsearch_repository
      raise NotImplementedError, "You must implement #{self.class}##{__method__}"
    end

    def self.current_elasticsearch_repository_class
      raise NotImplementedError, "You must implement #{self.class}##{__method__}"
    end

    def self.unindexed_elasticsearch_repositories
      elasticsearch_repositories.reject(&:index_exists?)
    end

    def self.indexed_elasticsearch_repositories
      elasticsearch_repositories.select(&:index_exists?)
    end

    def self.unindexed_bulk_import(batch_size: 1000)
      target_repositories = unindexed_elasticsearch_repositories
      target_repositories.each(&:create_index!)
      bulk_import(repositories: target_repositories, batch_size: batch_size)
    end

    def self.bulk_upsert(batch_size: 1000)
      bulk_import(repositories: indexed_elasticsearch_repositories, batch_size: 1000)
    end
  end
end
