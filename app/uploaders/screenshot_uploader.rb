# encoding: utf-8

class ScreenshotUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fill => [1280, nil]

  version :medium do
    process :resize_to_fill => [800, nil]
  end

  version :small do
    process :resize_to_fill => [400, nil]
  end
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
