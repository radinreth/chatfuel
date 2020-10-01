module Pumi
  class Province
    def address_en
      return super if id != "00"
      "Other Province"
    end

    def address_km
      return super if id != "00"
      "ខេត្តផ្សេងៗ"
    end
  end

  class District
    def address_en
      return super if id != "0000"
      "Other District, Other Province"
    end

    def address_km
      return super if id != "0000"
      "ស្រុកផ្សេងៗ, ខេត្តផ្សេងៗ"
    end
  end
end
