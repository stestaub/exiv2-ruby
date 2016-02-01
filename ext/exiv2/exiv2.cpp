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
      ;
  }
  RUBY_CATCH
}