require 'pathname'

class Exiv2::Image

  def file_name
    Pathname.new(self.path).basename.to_s
  end

  def extract_preview(preview_properties, path)
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

  def open
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

  def path
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

  def read_metadata
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

  def mime_type
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

  def extract_all_previews(path, file_name)
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

  def previews
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

end