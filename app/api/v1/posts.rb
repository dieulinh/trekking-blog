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
        requires :description, type: String
        requires :content, type: String
      end
      post '/' do
        byebug
        post = Post.create(title: params[:title], content: params[:content].html_safe, user_id: User.first.id, description: params[:description])
        present post, with: V1::Entities::Post
      end

      get '/:id' do
        post = Post.find(params[:id])
        present post, with: V1::Entities::Post
      end
    end
  end
end

