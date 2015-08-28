class Image < ActiveRecord::Base

  def image_file=(input_data)
      self.name = input_data.original_filename
      self.mime_type = input_data.content_type.chomp
      self.data = input_data.read
  end

end
