module HomeHelper
  def valueize str
    return str unless str =~ /results\/\d+/

  audio_tag str, controls: true, style: 'width: 200px'
  end
end
