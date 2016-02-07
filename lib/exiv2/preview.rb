module Exiv2

  # Metadata of a images preview files.
  class Preview

    # @return [String] The file extension
    def extension
      raise NotImplementedError.new 'This is only a function body for documentation'
    end

    # @return [Integer] The previews file size in bytes
    def size
      raise NotImplementedError.new 'This is only a function body for documentation'
    end

    # @return [String] The previews mime type
    def mime_type
      raise NotImplementedError.new 'This is only a function body for documentation'
    end

    # This is the internal identifier for the preview.
    # @return [Integer]
    def id
      raise NotImplementedError.new 'This is only a function body for documentation'
    end

    # @return [Integer] The width in px
    def width
      raise NotImplementedError.new 'This is only a function body for documentation'
    end

    # @return [Integer] The height in px
    def height
      raise NotImplementedError.new 'This is only a function body for documentation'
    end

  end
end