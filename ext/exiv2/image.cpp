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
    std::string file;

  public:
    ~Image() {
      Exiv2::XmpParser::terminate();
    }

    void open(std::string path) {
      image = Exiv2::ImageFactory::open(path);
      file = path;
    }

    std::string file_name(void) {
      return file;
    }

    void read_metadata(void) {
      image->readMetadata();
    }

    std::string mime_type(void) {
      std::string mime_type = image->mimeType();
      return mime_type;
    }

    void extract_all_previews(std::string const& path) {

      Exiv2::PreviewManager loader(*image);
      Exiv2::PreviewPropertiesList list = loader.getPreviewProperties();

      for (Exiv2::PreviewPropertiesList::iterator pos = list.begin(); pos != list.end(); pos++) {

        std::cout << pos->mimeType_
                << " preview, type " << pos->id_ << ", "
                << pos->size_ << " bytes, "
                << pos->width_ << 'x' << pos->height_ << " pixels"
                << "\n";

        std::cout << "Write file: "
                << path
                << "_preview"
                << Exiv2::toString(pos->id_)
                << "\n";

        Exiv2::PreviewImage preview = loader.getPreviewImage(*pos);
        preview.writeFile(path + "_preview" + Exiv2::toString(pos->id_));
      }
    }


  };

  Data_Type<Image> rb_cImage;

} // namespace
