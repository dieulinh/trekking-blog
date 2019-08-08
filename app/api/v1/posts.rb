module V1
  class Posts < Grape::API
    version 'v1', using: :path
    helpers Params::Pagination
    helpers Params::Tags


    resource :posts do
      params do
        use :pagination_params
        use :tags_params
      end
      get '/' do
        posts = Post.search(params[:terms], params[:size], params[:page])
        post_count = posts.total.value
        results = posts.results
        res = {}
        res[:posts] = results.map { |post| post.options }
        res[:total_pages] = post_count/params[:size] + (post_count%params[:size] > 0 ? 1 : 0)
        present res
      end

      params do
        requires :title, type: String
        requires :description, type: String
        requires :content, type: String
        requires :category, type: String
        requires :auth_token, type: String
      end

      post '/' do
        token = params.delete(:auth_token)
        user = User.find_by(authentication_token: token)
        return unauthorized! unless user
        post = Post.create(title: params[:title], category: params[:category], content: params[:content].html_safe, user_id: user.id, description: params[:description])
        present post, with: V1::Entities::Post
      end

      get '/:id' do
        post = Post.friendly.find(params[:id])
        present post, with: V1::Entities::Post
      end

      desc 'Update post endpoint'
      params do
        requires :auth_token, type: String
        optional :title, type: String
        optional :description, type: String
        optional :content, type: String
        optional :category, type: String
      end

      put '/:id' do
        token = params.delete(:auth_token)
        user = User.find_by(authentication_token: token)
        return unauthorized! unless user
        post = Post.friendly.find(params[:id])
        return unauthorized! unless user.id == post.user_id
        params[:content] = params[:content].html_safe
        post.update declared(params).except(:auth_token)
        present post, with: V1::Entities::Post
      end
    end
  end
end

