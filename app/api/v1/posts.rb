module V1
  class Posts < Grape::API
    resource :posts do
      get '/' do
      end
    end
  end
end

