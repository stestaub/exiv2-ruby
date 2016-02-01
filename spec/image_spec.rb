describe 'Exiv2::Image' do
  it 'should be a class' do
    expect(Exiv2::Image.class).to be_a(Class)
  end

  it 'should be possible to instantiate' do
    # noinspection RubyArgCount
    expect{Exiv2::Image.new}.not_to raise_error
  end

  describe 'instance' do
    # noinspection RubyArgCount
    let(:image) {Exiv2::Image.new}

    it 'should be possible to open image file' do
      expect{image.open('spec/fixtures/strom.jpg')}.not_to raise_error
    end

    it 'should read mime type from image' do
      image.open 'spec/fixtures/strom.jpg'
      image.read_metadata
      expect(image.mime_type).to eq 'image/jpeg'
    end

    it 'should return the full file path' do
      image.open 'spec/fixtures/strom.jpg'
      expect(image.path).to eq 'spec/fixtures/strom.jpg'
    end

    it 'should only return the file name' do
      image.open 'spec/fixtures/strom.jpg'
      expect(image.file_name).to eq 'strom.jpg'
    end

    it 'should extract all previews' do
      image.open 'spec/fixtures/DSC_0022.NEF'
      image.read_metadata
      image.extract_all_previews 'tmp/previews/'

      expect(File.exists?('tmp/previews/DSC_0022_preview1.NEF')).to be_truthy
      expect(File.exists?('tmp/previews/DSC_0022_preview2.NEF')).to be_truthy
      expect(File.exists?('tmp/previews/DSC_0022_preview3.NEF')).to be_truthy
    end
  end

end