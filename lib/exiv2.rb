require 'exiv2/version'
require 'exiv2/image'
require 'exiv2/preview'

# include the native extension
require 'exiv2/exiv2'

# A Ruby wrapper for the awesome exiv2 library. The goal of this gem is to provide easy
# access to most of the exiv2 libraries API, but most importantly, to extract previews
# of camara raw files.
# At the moment, only raw file extraction and some basic file information is implemented.
#
# See {Exiv2::Image} for example usage.
module Exiv2
end