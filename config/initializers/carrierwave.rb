require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
# require 'carrierwave/storage/fog'

# CarrierWave.configure do |config|
#   if Rails.env.development?
#     config.storage = :file
#   elsif Rails.env.production?
#     config.storage = :fog
#     config.fog_provider = 'fog/aws'
#     config.fog_credentials = {
#       provider: 'AWS',
#       aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
#       aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
#       region: 'ap-northeast-1'
#     }

#     config.fog_directory  = 'fato-bucket'
#     config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/fato-bucket'
#   end
# end

CarrierWave.configure do |config|
  if Rails.env.development?
    config.storage = :file
  elsif Rails.env.production?
  config.storage                             = :gcloud
  config.gcloud_bucket                       = 'fato-bucket'
  config.gcloud_bucket_is_public             = true
  config.gcloud_authenticated_url_expiration = 600
  config.gcloud_content_disposition          = 'attachment'
  
  config.gcloud_attributes = {
    expires: 600
  }
  
  config.gcloud_credentials = {
    gcloud_project: 'demoapp-260401',
    gcloud_keyfile: Rails.application.credentials.gcs_app_name_key.dump
  }
  end
end