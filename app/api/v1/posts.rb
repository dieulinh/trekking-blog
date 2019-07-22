module V1
  class Posts < Grape::API
    version 'v1', using: :path
    helpers Params::Pagination

    params do
      use :pagination_params
    end
    resource :posts do
      get '/' do
        posts = Post.with_attached_post_thumbnails.recent
        posts = posts.page(params[:page]).per(params[:size])
        res = {}
        res[:posts] = posts.map { |post| Entities::Post.new(post) }
        res[:total_pages] = posts.total_pages
        present res
      end

      params do
        requires :title, type: String
        requires :description, type: String
        requires :content, type: String
        requires :category, type: String
      end
      post '/' do
        post = Post.create(title: params[:title], category: params[:category], content: params[:content].html_safe, user_id: User.first.id, description: params[:description])
        present post, with: V1::Entities::Post
      end

      get '/:id' do
        post = Post.friendly.find(params[:id])
        present post, with: V1::Entities::Post
      end
    end
  end
end

