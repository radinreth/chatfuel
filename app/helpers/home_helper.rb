module HomeHelper
  def valueize(str)
    return str unless str.match? %r{(audioclip-\d+-\d+\.mp4)|(results\/\d+)}

    audio_tag str, controls: true, style: "width: 200px"
  end

  def no_messages
    @messages.count == 0
  end
end
