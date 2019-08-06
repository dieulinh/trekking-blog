
require 'elasticsearch/rails/tasks/import'
namespace :elasticsearch do
  desc 'unindexed repository bulk insert'
  task unindexed_bulk_import: :environment do
    ActiveRecord::Base.logger = nil
    Rails.application.eager_load!
    new_indices = []
    klasses = ActiveRecord::Base.descendants.select do |klass|
      klass.included_modules.include?(Elasticsearchable)
    end.each do |klass|
      message = "[Bulk Insert] Processing model: #{klass}... Record Count: #{klass.all.count}"
      klass.unindexed_bulk_import
      message = '[Bulk Insert] Imported.'
    end
  end

  desc 'indexed repository'
  task :sync, [:force] => :environment do |_t, _args|
    ActiveRecord::Base.logger = nil
    Rails.application.eager_load!
    ActiveRecord::Base.descendants.select do |klass|
      klass.included_modules.include?(Elasticsearchable)
    end.each do |klass|
      message = "[IMPORT] Processing model: #{klass}... Record Count: #{klass.all.count}"
      Rails.logger.info message
      puts message
      klass.bulk_upsert
      message = '[IMPORT] Imported.'
      Rails.logger.info message
      puts message
    end
  end

  desc 'unindexedなrepositoryのbulk insert'
  task unindexed_bulk_import: :environment do
    ActiveRecord::Base.logger = nil
    Rails.application.eager_load!
    new_indices = []
    klasses = ActiveRecord::Base.descendants.select do |klass|
      klass.included_modules.include?(Elasticsearchable)
    end.each do |klass|
      message = "[Bulk Insert] Processing model: #{klass}... Record Count: #{klass.all.count}"
      klass.unindexed_bulk_import
      message = '[Bulk Insert] Imported.'
    end
  end
end
