class PostCoverUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :tags =>  ['post-cover']
  process resize_to_fill: [500, 500]
end
