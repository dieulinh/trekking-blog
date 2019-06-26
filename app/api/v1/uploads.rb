module V1
  class Uploads < Grape::API
    version 'v1', using: :path
    resource :uploads do
      params do
        requires :file, type: File
      end
      post '/' do
        # Create a S3 client
        region = 'ap-southeast-1'
        client = Aws::S3::Client.new(region: region)

        bucket = 'trekking-app'
        # Sets a bucket to public-read
        client.put_bucket_acl({
          acl: "public-read",
          bucket: bucket,
        })
        object_key = params[:file][:filename]
        # Put an object in the public bucket
        client.put_object({
          bucket: bucket,
          key: object_key,
          body: (params[:file][:tempfile]),
        })
        # Setting the object to public-read
        client.put_object_acl({
          acl: "public-read",
          bucket: bucket,
          key: object_key,
        })
        present "http://#{bucket}.s3-#{region}.amazonaws.com/#{object_key}"
      end
    end
  end
end
