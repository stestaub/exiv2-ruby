context "XMP data" do
  subject do
    image = Exiv2::Image.new
    image.open Pathname.new('spec/fixtures/test.jpg')
    image.xmp_data
  end

  it "should read XMP data" do
    expect(subject).to be_a(Exiv2::XmpData)
    expect(subject.inspect).to eq('#<Exiv2::XmpData: {"Xmp.dc.description"=>"lang=\"x-default\" This is a description", "Xmp.dc.title"=>"lang=\"x-default\" Pickled"}>')
    expect(subject.to_a).to eq([
                                     ["Xmp.dc.title", "lang=\"x-default\" Pickled"],
                                     ["Xmp.dc.description", "lang=\"x-default\" This is a description"]
                                 ])
  end

  it "should convert xmp data into a hash" do
    xmp_hash = subject.to_hash
    expect(xmp_hash).to be_a(Hash)
    expect(xmp_hash).to eq({
                               "Xmp.dc.title"       => "lang=\"x-default\" Pickled",
                               "Xmp.dc.description" => "lang=\"x-default\" This is a description"
                           })
  end

  # it "should write XMP data" do
  #   subject["Xmp.dc.title"] = "lang=\"x-default\" Changed!"
  #   expect(subject.to_hash["Xmp.dc.title"]).to eq("lang=\"x-default\" Changed!")
  # end
  #
  # it "should set XMP data" do
  #   subject["Xmp.dc.title"] = "A New Title"
  #   expect(subject.to_hash["Xmp.dc.title"]).to eq("lang=\"x-default\" A New Title")
  # end
  #
  # it "should set multiply XMP data values" do
  #   subject["Xmp.dc.title"] = ["abc", "cde"]
  #   expect(subject.to_hash["Xmp.dc.title"]).to eq(["lang=\"x-default\" abc", "lang=\"x-default\" cde"])
  # end
  #
  # it "should delete one value of XMP data" do
  #   subject["Xmp.dc.title"] = ["abc", "cde"]
  #   subject.delete("Xmp.dc.title")
  #   expect(subject.to_hash["Xmp.dc.title"]).to eq("lang=\"x-default\" cde")
  # end
  #
  # it "should delete all values of XMP data" do
  #   subject.delete_all("Xmp.dc.title")
  #   expect(subject.to_hash["Xmp.dc.title"]).to eq(nil)
  # end
end