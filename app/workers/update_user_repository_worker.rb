class UpdateUserRepositoryWorker
  include Sidekiq::Worker

  def perform(user_id, *args)
    user = Trekker.find(user_id)
    Trekker.update_repository(user)
  end
end
