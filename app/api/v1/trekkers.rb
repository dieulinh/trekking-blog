module V1
  class Trekkers < Grape::API
    version 'v1', using: :path
    helpers Params::Pagination

    resources :trekkers do
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
    end
  end
end
