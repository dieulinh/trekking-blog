class UpdatePostRepositoryWorker
  include Sidekiq::Worker

  def perform(post_id, *args)
    post = Post.find(post_id)
    begin
      Post.update_repository(post)
    rescue
      Rails.cache.redis.set("all_post:#{post.slug}", post.attributes.merge(slug: post.slug,
        category: post.category,
        thumb_url: post.thumb_url,
        mobile_thumb_url: post.mobile_thumb_url).to_json)
      Rails.cache.redis.expire("all_post:#{post.slug}", 24.hours)
    end
  end
end
