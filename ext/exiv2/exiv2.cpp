#include <iostream>
#include "image.cpp"
#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"
#include "rice/String.hpp"

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

extern "C"
void Init_exiv2(void)
{
  RUBY_TRY
  {

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
      .define_method("read_metadata", &Image::read_metadata)
      .define_method("mime_type", &Image::mime_type)
      .define_method("extract_all_previews", &Image::extract_all_previews)
      .define_method("extract_preview", &Image::extract_preview)
      .define_method("previews", &Image::previews)
      ;
  }
  RUBY_CATCH
}