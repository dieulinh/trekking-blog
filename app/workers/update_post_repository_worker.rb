class UpdatePostRepositoryWorker
  include Sidekiq::Worker

  def perform(post_id, *args)
    post = Post.find(post_id)
    begin
      Post.update_repository(post)
    rescue
      unless Rails.cache.redis.get("all_post:#{post.slug}")
        Rails.cache.redis.set("all_post:#{post.slug}", post.attributes.to_json)
        Rails.cache.redis.expire("all_post:#{post.slug}", 24.hours)
      end
    end
  end
end
