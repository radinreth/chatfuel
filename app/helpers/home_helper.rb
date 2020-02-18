module HomeHelper
  def valueize str
    return str unless str =~ /(audioclip-\d+-\d+\.mp4)|(results\/\d+)/

  audio_tag str, controls: true, style: 'width: 200px'
  end
end
