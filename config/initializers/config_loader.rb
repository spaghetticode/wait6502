APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/config.yml")

Paperclip.interpolates :timestamp do |attachment, style|
  attachment.instance.updated_at.to_s(:db).gsub(/\D/, '')
end
