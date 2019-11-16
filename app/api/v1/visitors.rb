module V1
  class Visitors < Grape::API
    version 'v1', using: :path
    helpers Params::Pagination
    helpers Params::Tags

    resource :visitors do
      desc 'add statistic visitor'
      params do
        requires :city, type: String
        requires :continent_code, type: String
        requires :continent_name, type: String
        requires :country_capital, type: String
        requires :country_code2, type: String
        requires :country_code3, type: String
        requires :country_name, type: String
        requires :country_tld, type: String
        requires :currency, type: Hash do
          requires :code, type: String
          requires :name, type: String
          requires :symbol, type: String
        end
        requires :district, type: String
        requires :geoname_id, type: String
        requires :ip, type: String
        requires :is_eu, type: String
        requires :isp, type: String
        requires :latitude, type: String
        requires :longitude, type: String
        requires :state_prov, type: String
        requires :time_zone, type: Hash do
          optional :current_time, type: String # "2019-11-16 19:55:08.268+0700"
          optional :current_time_unix, type: String # 1573908908.268
          optional :dst_savings, type: String # 0
          optional :is_dst, type: String # false
          optional :name, type: String # : "Asia/Ho_Chi_Minh"
          optional :offset, type: String # 7
        end
        requires :zipcode, type: String
      end

      post '/' do
        post = Visitor.create(declared(params).merge(currency: params[:currency].to_s, time_zone: params[:time_zone].to_s))
        present post, status: 201
      end
    end
  end
end
