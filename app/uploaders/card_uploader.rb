# encoding: utf-8

class CardUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_limit => [800, nil]

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
