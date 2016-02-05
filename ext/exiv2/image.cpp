#include "exiv2/exiv2.hpp"
#include <iostream>
#include <vector>
#include "rice/Data_Type.hpp"
#include "rice/Array.hpp"

using namespace Rice;
namespace
{

  class Image
  {
  private:
    Exiv2::Image* image;
    std::string file;

  public:
    Exiv2::PreviewPropertiesList prevPropList;

    ~Image() {
      delete image;
      Exiv2::XmpParser::terminate();
    }

    void open(std::string path) {
      Exiv2::Image::AutoPtr img_ptr = Exiv2::ImageFactory::open(path);
      image = img_ptr.release();
      file = path;
      read_metadata();
    }

    std::string file_name(void) {
      return file;
    }

    void read_metadata(void) {
      image->readMetadata();
      Exiv2::PreviewManager loader(*image);
      prevPropList = loader.getPreviewProperties();
    }

    std::string mime_type(void) {
      std::string mime_type = image->mimeType();
      return mime_type;
    }

    void extract_all_previews(std::string const& path, std::string const& _filename) {
      Exiv2::PreviewManager loader(*image);
      Exiv2::PreviewPropertiesList list = loader.getPreviewProperties();
      int i = 1;
      for (Exiv2::PreviewPropertiesList::iterator pos = list.begin(); pos != list.end(); pos++) {
        Exiv2::PreviewImage preview = loader.getPreviewImage(*pos);
        preview.writeFile(path + _filename + Exiv2::toString(i++));
      }
    }

    void extract_preview(Exiv2::PreviewProperties &prevProperties, std::string const& _path) {
      Exiv2::PreviewManager loader(*image);
      Exiv2::PreviewImage preview = loader.getPreviewImage(prevProperties);
      preview.writeFile(_path);
    }

    Array previews( void ) {
      return *new Array(prevPropList.begin(), prevPropList.end());
    }

  };

  Data_Type<Image> rb_cImage;
  Data_Type<Exiv2::PreviewProperties> rb_cPreviewImage;

} // namespace
