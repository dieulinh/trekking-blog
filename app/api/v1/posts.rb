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
        requires :user_id, type: Integer
      end
      post '/' do
        sanitized_content = Sanitize.fragment(params[:content], Sanitize::Config::RESTRICTED)
        post = Post.create(title: params[:title], content: sanitized_content, user_id: params[:user_id])
        present post, with: V1::Entities::Post
      end
    end
  end
end

