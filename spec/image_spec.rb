describe Exiv2::Image do

  describe 'instance' do

    it 'should be possible to open image file' do
      expect{subject.open('spec/fixtures/strom.jpg')}.not_to raise_error
    end

    it 'should handle path name in open method' do
      expect{subject.open(Pathname.new('spec/fixtures/strom.jpg'))}.not_to raise_error
    end

    it 'should read mime type from image' do
      subject.open 'spec/fixtures/strom.jpg'
      expect(subject.mime_type).to eq 'image/jpeg'
    end

    it 'should return the full file path' do
      subject.open 'spec/fixtures/strom.jpg'
      expect(subject.path).to eq 'spec/fixtures/strom.jpg'
    end

    it 'should only return the file name' do
      subject.open 'spec/fixtures/strom.jpg'
      expect(subject.file_name).to eq 'strom.jpg'
    end

    describe 'Previews' do
      before do
        subject.open 'spec/fixtures/DSC_0022.NEF'
      end

      it 'should extract all previews', :clean_tmp do
        subject.extract_all_previews 'tmp/rspec/previews/', 'preview'
        subject.extract_all_previews 'tmp/rspec/previews/', 'preview'
        subject.extract_all_previews 'tmp/rspec/previews/', 'preview'

        # Example file contains 3 previews. It should extract all of them to specified location
        expect(File.exist?('tmp/rspec/previews/preview1.tif')).to be_truthy # first one is actually a tiff file...
        expect(File.exist?('tmp/rspec/previews/preview2.jpg')).to be_truthy
        expect(File.exist?('tmp/rspec/previews/preview3.jpg')).to be_truthy
      end

      context 'preview list' do

        let(:previews) {subject.previews}

        it 'should have enumerable preview properties list' do
          expect(previews).to be_a(Enumerable)
        end

        it 'should contain 3 elements' do
          expect(previews.size).to eq 3
        end

        it 'first elements should have size' do
          expect(previews.first.size).to be > 0
        end

        it 'first elements should have extension' do
          expect(previews.first.extension).to eq '.tif'
        end

        it 'first elements should have id' do
          expect(previews.first.id).to be > 0
        end

        it 'first element should have width and height' do
          expect(previews.first.width).to be > 0
          expect(previews.first.height).to be > 0
        end

        it 'should be possible to write a preivew to disk', :clean_tmp do
          subject.extract_preview(previews.first, 'tmp/rspec/previews/preview')
          subject.extract_preview(previews.last, 'tmp/rspec/previews/preview2')
          expect(File.exist?('tmp/rspec/previews/preview.tif')).to be_truthy
          expect(File.exist?('tmp/rspec/previews/preview2.jpg')).to be_truthy
        end
      end
    end

  end

end