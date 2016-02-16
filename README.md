# Exiv2::Ruby
[![Build Status](https://travis-ci.org/stestaub/exiv2-ruby.svg?branch=master)](https://travis-ci.org/stestaub/exiv2-ruby)
[![Code Climate](https://codeclimate.com/github/stestaub/exiv2-ruby/badges/gpa.svg)](https://codeclimate.com/github/stestaub/exiv2-ruby)

A Ruby wrapper for the awesome [exiv2](http://www.exiv2.org/) library. The goal of this gem is to provide easy access to most of the exiv2 libraries API,
but most importantly, to extract previews of camara raw files.

At the moment, only raw file extraction and reading exif, iptc and xmp data is possible.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'exiv2-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install exiv2-ruby

Be sure to have the exiv2 dev libraries installed:

    $ sudo apt-get install -y exiv2 libexiv2-dev

## Usage
```ruby
require 'exiv2'

image = Exiv2::Image.new

# open an image raw file
image.open 'path/to/image.nef'

# get information about the file
image.path
#=> "path/to/image.nef"
image.mime_type
#=> "image/x-nikon-nef"

# extract previews
# will create files (some/location/_preview1.tif, some/location/_preview2.jpg, ...)
image.extract_all_previews('some/location/', '_preview')

# Get information about previews
preview = image.previews.first
preview.mime_type
#=> "image/tiff"
preview.extension
#=> ".tif"
preveiw.size
#=> 57600
"#{preview.width}px x #{preview.height}px"
#=> "160px x 120px"

# Extract single preview
# creates a file 'path/to/extract/file_name.tif'
image.extract_preview(preview, 'path/to/extract/file_name')

# free the memory
image.destroy!
```

### Accessing Meta Data
Metadata of images can be accessed by the methods Image#exif_data, Image#xmp_data and Image#iptc_data. The Method returns
an enumerator that allows to access the key value pairs of the corresponding type.

Example:

```ruby
image.exif_data.each do |key, value|
  print "#{key}: #{value}\n"
end

image.exif_data.each { ... }
image.xmp_data.each { ... }

iptc_data_hash  = image.iptc_data.to_hash
xmp_data_hash   = image.xmp_data.to_hash
```

## What's coming next
This is a very alpha version, so not much is implemented so far. The following is planed for future versions:

* Support write Exif, XMP and IPTC data
* Better Error Handling
* Fallback to raw rendering for previews if no previews embedded
* Support for Carrierwave

## Contributing

1. Fork it ( https://github.com/stestaub/exiv2-ruby/fork )
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request


## Credits
The way metadata is accessed is heavily inspired by [https://github.com/envato/exiv2], but ported to use Rice.