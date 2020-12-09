module HomeHelper
  def valueize(str)
    return str unless str.match? %r{(audioclip-\d+-\d+\.mp4)|(results\/\d+)}

    audio_tag str, controls: true, style: "width: 200px"
  end

  def no_messages
    @messages.count == 0
  end

  def render_from_string(str, size: "24x24")
    return str if str.empty? || !valid_image?(str)

    image_tag str, size: size
  end

  def valid_image?(url)
    url =~ %r{.+\.(gif|jpe?g|png)}i
  end
end
