require 'benchmark'
describe 'IPTC Data' do

  subject do
    image = Exiv2::Image.new
    image.open Pathname.new('spec/fixtures/test.jpg')
    image.iptc_data
  end

  it 'should read IPTC data' do
    expect(subject).to be_a(Exiv2::IptcData)
    expect(subject.inspect).to eq('#<Exiv2::IptcData: {"Iptc.Application2.Caption"=>"Rhubarb rhubarb rhubard", "Iptc.Application2.Keywords"=>["fish", "custard"]}>')
    expect(subject.to_a).to eq([
                                      ['Iptc.Application2.Caption', 'Rhubarb rhubarb rhubard'],
                                      %w(Iptc.Application2.Keywords fish),
                                      %w(Iptc.Application2.Keywords custard)
                                  ])
  end

  it 'should convert iptc data into a hash' do
    iptc_hash = subject.to_hash
    expect(iptc_hash).to be_a(Hash)
    expect(iptc_hash).to eq({
                                'Iptc.Application2.Caption' => 'Rhubarb rhubarb rhubard',
                                'Iptc.Application2.Keywords' => %w(fish custard)
                            })
  end


end