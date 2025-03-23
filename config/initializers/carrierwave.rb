# # CarrierWave配置
# # 解决MiniMagick和图片URL生成的问题

# CarrierWave.configure do |config|
#   # 指定存储类型为文件系统存储
#   config.storage = :file

#   # 允许处理远程图片URL
#   config.cache_storage = :file

#   # 配置MiniMagick命令行路径
#   # 如果系统路径中能找到ImageMagick，则不需要显式设置
#   # config.mini_magick.cli_path = "/usr/bin/convert" # 根据实际路径调整
  
#   # 启用基于文件的URL
#   config.root = Rails.root.join('public')
#   config.asset_host = ActionController::Base.asset_host

#   # 允许使用白名单中的所有图片处理方法
#   config.process_uri_uri_whitelist = []
  
#   # 设置处理错误的方式
#   config.ignore_integrity_errors = false
#   config.ignore_processing_errors = false
#   config.ignore_download_errors = false
  
#   # 添加debug日志
#   if Rails.env.development?
#     config.enable_processing = true
#     Rails.logger.info "CarrierWave配置已加载，存储模式: #{config.storage}"
#   end
  
#   # 允许处理大图片，但限制最大尺寸以避免内存问题
#   # 超过此限制的图片将被缩小
#   # config.mini_magick[:validate_dimensions] = true
#   # config.mini_magick[:limit_memory_usage] = true
#   # config.mini_magick[:memory_limit] = 128
# end

# # 确保上传目录存在
# FileUtils.mkdir_p(Rails.root.join('public', 'uploads')) unless File.directory?(Rails.root.join('public', 'uploads'))