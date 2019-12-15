class UpdatePostRepositoryWorker
  include Sidekiq::Worker

  def perform(post_id, *args)
    post = Post.find(post_id)
    Post.update_repository(post)
  end
end
