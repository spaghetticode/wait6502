APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/config.yml")

Paperclip::Attachment.interpolations[:timestamp] = proc do |attachment, style|
  attachment.instance.updated_at.to_s(:db).gsub(/\D/, '')
end
