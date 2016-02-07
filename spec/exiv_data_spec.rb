describe 'Exiv Data' do

  subject do
    image = Exiv2::Image.new
    image.open('spec/fixtures/photo_with_utf8_description.jpg')
    image.exif_data
  end

  describe 'exif data' do

    it 'reads UTF-8 data' do
      description = subject['Exif.Image.ImageDescription']
      if description.respond_to? :encoding # Only in Ruby 1.9+
        expect(description.encoding).to eq(Encoding::UTF_8)
      end
      expect(description).to eq('UTF-8 description. ☃ł㌎')
    end

  end

end