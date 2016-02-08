require 'pathname'

# The main Class that provides common methods to interact with
# the images metadata and possible previews.
#
# == Example Usage
#     image = Exiv2::Image.new
#
#     # open an image raw file
#     image.open 'path/to/image.nef'
#
#     # get information about the file
#     image.path
#     #=> "path/to/image.nef"
#     image.mime_type
#     #=> "image/x-nikon-nef"
#
#     # extract previews
#     # will create files (some/location/_preview1.tif, some/location/_preview2.jpg, ...)
#     image.extract_all_previews('some/location/', '_preview')
#
#     # Get information about previews
#     preview = image.previews.first
#     preview.mime_type
#     #=> "image/tiff"
#     preview.extension
#     #=> ".tif"
#     preveiw.size
#     #=> 57600
#     "#{preview.width}px x #{preview.height}px"
#     #=> "160px x 120px"
#
#     # Extract single preview
#     # creates a file 'path/to/extract/file_name.tif'
#     image.extract_preview(preview, 'path/to/extract/file_name')
#
class Exiv2::Image

  # Get the file name of the loaded image
  #
  # @return [String] The name of the loaded file.
  def file_name
    Pathname.new(self.path).basename.to_s
  end

  # Most Camera RAW images have previews embedded. This method extracts the preview
  # defined by the preview properties to the given path. The path should include the filename
  # as well but not the file extension. The file extension is added automatically be the
  # extractor.
  #
  # == Example:
  #     image = Image.new
  #     image.open 'lake.nef'
  #     preview = image.previews.first
  #     image.extract_preview preview, 'previews/lake'
  #     #=> writes preview/lake.jpg
  #
  # @param [Preview] preview_properties The previews properties that should be extracted.
  # @param [String] path The path, including the file name but not its extension.
  #
  def extract_preview(preview_properties, path)
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

  # Opens a file and reads its metadata.
  #
  # @param [String | Pathname] file_path The path to the image
  #
  def open(file_path)
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

  # Returns the full file path of the image including the filename.
  # @return [String] The file path.
  def path
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

  # Reads the metadata of the file. This is called by the open method and is usually not
  # intended to be called manually.
  #
  # The only reason this method may be called, is when metadata of the image ws changed
  # from an other source and you want to refresh the cached metadata.
  def read_metadata
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

  # Returns the mime type of the image.
  # @return [String] The mime type of the image.
  def mime_type
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

  # Extracts all available previews to the given path with the given file name.
  # A sequence number will be automatically appended on each file. The file name
  # should not include the extension, it will be added automatically based on
  # the previews file type.
  #
  # @param [String] path The file path to store image
  # @param [String] file_name The base name for the file to write.
  def extract_all_previews(path, file_name)
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

  # Returns an Array of available previews on this image. This is usually only possible
  # on images that can have embedded previews, such as Camera Raw files.
  #
  # The {Image::Preview} objects contain only meta information about the previews and can be used
  # As identifier for the {Image#extract_preview} method.
  #
  # @return [Array] An array of {Preview} objects
  def previews
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

  # Returns an {ExifData} object which is an enumerable and allows to access
  # each exif key value pair.
  #
  # @return [ExifData]
  def exif_data
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

  # Returns an {XmpData} object which is an enumerable and allows to access
  # each xmp key value pair.
  #
  # @return [XmpData]
  def xmp_data
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

  # Returns an {IptcData} object which is an enumerable and allows to access
  # each iptc key value pair.
  #
  # @return [IptcData]
  def iptc_data
    raise NotImplementedError.new 'This is only a function body for documentation'
  end

end