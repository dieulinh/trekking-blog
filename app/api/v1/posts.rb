module V1
  class Posts < Grape::API
    version 'v1', using: :path
    helpers Shared::Authentication
    helpers Params::Pagination
    helpers Params::Tags
    include Shared::AuthorizationKit

    resource :posts do
      desc 'List post endpoint'
      params do
        use :pagination_params
        use :tags_params
      end
      get '/' do
        res = {}
        begin
          posts = Post.search(params[:terms], params[:size], params[:page])
          post_count = posts.total.value
          results = posts.results
          res[:posts] = results.map { |post| post.options }
          res[:total_pages] = post_count/params[:size] + (post_count%params[:size] > 0 ? 1 : 0)
        rescue Exception => e
          results = params[:terms].present? ? Post.search_term(params[:terms]).map(&:attributes) : Post.where(is_private: false).order('updated_at DESC').map(&:attributes)
          post_count = results.size
          res[:posts] = results
          res[:total_pages] = post_count/params[:size] + (post_count%params[:size] > 0 ? 1 : 0)
        end

        present res
      end
      desc 'Hacker news endpoint'
      get '/news' do
        res = {}
        if Rails.cache.redis.keys.any? {|k| k=~/hacker_posts:*/}
          posts = Rails.cache.redis.keys.map {|k| k=~/hacker_posts:*/ ? JSON.parse(Rails.cache.redis.get(k)) : nil }.compact
          # {"link"=>"https://d2l.ai/", "text"=>"Dive into Deep Learning", "short_content"=>{"title"=>"", "content"=>"", "thumbnail"=>"", "author"=>"", "short_desc"=>""}}
          res["posts"] = posts.map {|post| {'title' => post['text'], 'thumb_url' => post['short_content']['thumbnail'], 'description' => post['short_content']['short_desc'], 'link' => post['link']}}
        else
          res = WebsiteScaper.read_page_content

          res = res.stringify_keys
          readable_content = res["posts"]
          readable_content.each do |link|
            # Rails.cache.redis.set("hacker_posts:#{link['link']}", link.to_json)
            unless Rails.cache.redis.get("hacker_posts:#{link['link']}")
              Rails.cache.redis.set("hacker_posts:#{link['link']}", link.to_json)
            end
          end
        end

        present res
      end

      desc 'Hacker news details link'
      params do
        requires :news_url, type: String
      end
      get '/details' do
        url = params[:news_url]
        post = WebsiteScaper.parse_article(url)
        post_hash = {'title' => post['title'], 'thumb_url' => post['thumbnail'], 'description' => post['short_desc'], 'link' => post['link'], 'category' => 'technology' }
        present post_hash
      end

      params do
        requires :title, type: String
        requires :description, type: String
        requires :content, type: String
        requires :category, type: String
        requires :auth_token, type: String
      end

      post '/' do
        authenticate_user!
        post = Post.create(title: params[:title], category: params[:category], content: params[:content].html_safe, user_id: current_user.id, description: params[:description])
        present post, with: V1::Entities::Post
      end

      get '/:id' do
        post = Post.friendly.find(params[:id])
        present post, with: V1::Entities::Post
      end

      desc 'Update post endpoint'
      params do
        optional :title, type: String
        optional :description, type: String
        optional :content, type: String
        optional :category, type: String
      end

      put '/:id' do
        authenticate_user!
        post = Post.friendly.find(params[:id])
        authorize post, :update?
        params[:content] = params[:content].html_safe
        post.update declared(params).except(:auth_token)
        present post, with: V1::Entities::Post
      end
    end
  end
end

