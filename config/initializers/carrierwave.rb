require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'


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
    gcloud_keyfile: 'config/gcs.json'
  }
  end
end