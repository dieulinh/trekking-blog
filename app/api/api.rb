class API < Grape::API
  format :json
  mount Login
  mount V1::Posts
  mount V1::Uploads

  rescue_from Grape::Exceptions::ValidationErrors  do |e|
    rack_response({
      status: e.status,
      error_msg: e.message
  }.to_json, 400)
  end
end
