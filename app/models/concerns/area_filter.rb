class AreaFilter
  def self.fetch(*codes)
    return codes_beside_pilot if parse(codes).include?(other_code)

    codes.flatten & pilot_codes
  end

  private

  def self.parse(codes)
    return codes.flatten if codes.is_a? Array

    codes.to_s.split(',') rescue []
  end
end
