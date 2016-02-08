require 'benchmark'
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

  describe 'performance' do
    let(:n) { 1 }

    it 'should be faster with find' do
      # This is very interesting. It is only faster when
      # executing about thousand times. for single executions
      # bracket access is faster
      Benchmark.bm(10) do |x|
        x.report('find:') { n.times {subject.find { |k, v| k == 'Exif.Image.DateTimeOriginal' }} }
        x.report('bracket:') { n.times {subject['Exif.Image.DateTimeOriginal']} }
        x.report('to_hash:') { n.times {subject.to_hash} }
      end
    end


  end

end