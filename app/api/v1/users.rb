module V1
  class Users < Grape::API
    version 'v1', using: :path
    helpers Params::Pagination

    resources :users do
      desc 'List trekkers endpoint'
      params do
        use :pagination_params
      end
      get '/' do
        trekkers = Trekker.search(params[:terms], params[:size], params[:page])
        trekker_count = trekkers.total.value
        results = trekkers.results
        res = {}
        res[:trekkers] = results.map { |post| post.options }
        res[:total_pages] = trekker_count/params[:size] + (trekker_count%params[:size] > 0 ? 1 : 0)
        present res
      end

      params do
        requires :location, type: String
        requires :lat, type: Float
        requires :lon, type: Float
        requires :trekker_name, type: String
      end

      post '/' do
        declared_params = declared(params).except(:lon, :lat)
        user = Trekker.create declared_params.merge(user_id: User.first.id, location_lonlat: "POINT(#{params[:lon]} #{params[:lat]})")
        UpdateUserRepositoryWorker.perform_async(user.id)
        present user, with: Entities::UserProfile
      end

      desc 'Show user information'
      get '/:id' do
        post = Trekker.find(params[:id])
        present post, with: Entities::UserProfile
      end
    end
  end
end
