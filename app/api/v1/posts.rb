module V1
  class Posts < Grape::API
    version 'v1', using: :path
    resource :posts do
      get '/' do
        posts = Post.recent
        present posts, with: V1::Entities::Post
      end

      params do
        requires :title, type: String
        requires :content, type: String
      end
      post '/' do
        byebug
        post = Post.create(declared(params).merge(user_id: User.first.id))
        present post, with: V1::Entities::Post
      end
    end
  end
end

