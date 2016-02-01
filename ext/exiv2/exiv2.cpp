#include <iostream>
#include "image.cpp"
#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"
#include "rice/String.hpp"


extern "C"
void Init_exiv2(void)
{
  RUBY_TRY
  {

    Rice::Module rb_mExiv2 = define_module("Exiv2");

    rb_cImage =
      define_class_under<Image>(rb_mExiv2, "Image")
      .define_constructor(Constructor<Image>())
      .define_method("open", &Image::open)
      .define_method("path", &Image::file_name)
      .define_method("read_metadata", &Image::read_metadata)
      .define_method("mime_type", &Image::mime_type)
      .define_method("extract_all_previews", &Image::extract_all_previews)
      ;
  }
  RUBY_CATCH
}