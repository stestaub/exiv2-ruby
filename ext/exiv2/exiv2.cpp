#include <iostream>
#include "image.cpp"
#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"
#include "rice/String.hpp"

// Preview Properties ------------------------------------------------------
static std::string previewExtension(Exiv2::PreviewProperties self) {
  return self.extension_;
}

static int previewSize(Exiv2::PreviewProperties self) {
  return self.size_;
}

static std::string previewMimeType(Exiv2::PreviewProperties self) {
  return self.mimeType_;
}

static int previewId(Exiv2::PreviewProperties self) {
  return self.id_;
}

static int previewWidth(Exiv2::PreviewProperties self) {
  return self.width_;
}

static int previewHeight(Exiv2::PreviewProperties self) {
  return self.height_;
}
// End - Preview Properties -------------------------------------------------


// Create a Ruby string from a C++ std::string. Ths is copied from https://github.com/envato/exiv2
static VALUE to_ruby_string(const std::string& string) {
  VALUE str = rb_str_new(string.data(), string.length());

  // force UTF-8 encoding in Ruby 1.9+
  ID forceEncodingId = rb_intern("force_encoding");
  if(rb_respond_to(str, forceEncodingId)) {
      rb_funcall(str, forceEncodingId, 1, rb_str_new("UTF-8", 5));
  }
  return str;
}

// Ths is copied from https://github.com/envato/exiv2 and slightly adapted to use Rice
template <class T>
static Object meta_data_each(T self) {
  for(typename T::iterator i = self.begin(); i != self.end(); i++) {
    VALUE key   = to_ruby_string(i->key());
    VALUE value = to_ruby_string(i->value().toString());
    rb_yield(rb_ary_new3(2, key, value));
  }

  return Qnil;
}

extern "C"
void Init_exiv2(void)
{
  RUBY_TRY
  {

    VALUE enumerable_module = rb_const_get(rb_cObject, rb_intern("Enumerable"));
    Rice::Module rb_mExiv2 = define_module("Exiv2");

    rb_cPreviewImage =
      define_class_under<Exiv2::PreviewProperties>(rb_mExiv2, "Preview")
      .define_method("extension", previewExtension)
      .define_method("mime_type", previewMimeType)
      .define_method("id", previewId)
      .define_method("size", previewSize)
      .define_method("width", previewWidth)
      .define_method("height", previewHeight)
      ;

    rb_cImage =
      define_class_under<Image>(rb_mExiv2, "Image")
      .define_constructor(Constructor<Image>())
      .define_method("open", &Image::open)
      .define_method("path", &Image::file_name)
      .define_method("destroy!", &Image::destroy)
      .define_method("read_metadata", &Image::read_metadata)
      .define_method("mime_type", &Image::mime_type)
      .define_method("extract_all_previews", &Image::extract_all_previews)
      .define_method("extract_preview", &Image::extract_preview)
      .define_method("previews", &Image::previews)
      .define_method("exif_data", &Image::exif_data)
      .define_method("iptc_data", &Image::iptc_data)
      .define_method("xmp_data", &Image::xmp_data)
      ;

    rb_cExifData =
      define_class_under<Exiv2::ExifData>(rb_mExiv2, "ExifData")
      .include_module(enumerable_module)
      .define_method("each", meta_data_each<Exiv2::ExifData>)
      ;

    rb_cIptcData =
      define_class_under<Exiv2::IptcData>(rb_mExiv2, "IptcData")
      .include_module(enumerable_module)
      .define_method("each", meta_data_each<Exiv2::IptcData>)
      ;

    rb_cXmpData =
      define_class_under<Exiv2::XmpData>(rb_mExiv2, "XmpData")
      .include_module(enumerable_module)
      .define_method("each", meta_data_each<Exiv2::XmpData>)
      ;
  }
  RUBY_CATCH
}