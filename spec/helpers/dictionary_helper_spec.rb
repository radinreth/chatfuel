RSpec.describe DictionaryHelper do
  it "#toggle_class_name" do
    expect(toggle_class_name("active", true)).to eq("active")
  end
end
