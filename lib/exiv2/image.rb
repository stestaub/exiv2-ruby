require 'pathname'

class Exiv2::Image

  def file_name
    Pathname.new(self.path).basename.to_s
  end

end