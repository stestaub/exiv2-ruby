#include <iostream>
#include "exiv2/exiv2.hpp"
#include "rice/Data_Type.hpp"

using namespace Rice;
namespace
{
  class Image
  {
  private:
    Exiv2::Image::AutoPtr image;

  public:
    void open(std::string path) {

      image = Exiv2::ImageFactory::open(path);
      image->readMetadata();
      std::cout << "Image loaded, mime type: " << image->mimeType() << std::endl;
    }


  };

  Data_Type<Image> rb_cImage;

} // namespace
