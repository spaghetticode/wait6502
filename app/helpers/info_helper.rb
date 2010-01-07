module InfoHelper
  def computer_image(data, options={})
    filename, text = data
    image_tag "/images/carousel/#{filename}.jpg", {:alt => text}.merge(options)
  end
end
