# Exiv2::Ruby
[![Build Status](https://travis-ci.org/stestaub/exiv2-ruby.svg?branch=master)](https://travis-ci.org/stestaub/exiv2-ruby)

A Ruby wrapper for the awesome [exiv2](http://www.exiv2.org/) library. The goal of this gem is to provide easy access to most of the exiv2 libraries API,
but most importantly, to extract previews of camara raw files.

At the moment, only raw file extraction and some basic file information is implemented.

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
require 'exiv2-ruby'

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
```

## What's coming next
This is a very alpha version, so not much is implemented so far. The following is planed for future versions:

* Support Read/Write Exif, XMP and IPTC data
* Better Error Handling
* Improve documentation (inline docs)
* Fallback to raw rendering for previews if no previews embedded
* Support for Carrierwave

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/stestaub/exiv2-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
