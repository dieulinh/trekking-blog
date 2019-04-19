module V1
  class Posts < Grape::API
    version 'v1', using: :path
    resource :posts do
      get '/' do
        posts = Post.recent
        present posts
      end
    end
  end
end

