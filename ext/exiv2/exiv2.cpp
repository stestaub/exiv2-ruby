#include "rice/Class.hpp"
#include "exiv2/exiv2.hpp"

using namespace Rice;

extern "C"
void Init_exiv2() {
  Class rb_cImageFactory = define_class("ImageFactory");


}