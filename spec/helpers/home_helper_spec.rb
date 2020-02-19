RSpec.describe HomeHelper do
  describe '.valueize' do
    context 'plain' do
      it 'renders plain value if it behaves like plain text' do
        value = valueize('plain')

        expect(value).to eq value
      end
    end

    context 'url' do
      it 'render audio tag if behaves like audio' do
        url = '...736_n.mp4/audioclip-1582097598-2369.mp4?_nc_cat=...'
        value = valueize(url)

        p value
        expect(value).to eq %(<audio controls=\"controls\" style=\"width: 200px\" src=\"/audios/...736_n.mp4/audioclip-1582097598-2369.mp4?_nc_cat=...\"></audio>)
      end
    end
  end
end
