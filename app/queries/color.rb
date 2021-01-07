class Color
  class << self
    def generate(n = 0)
      n.zero? ? hexs : hexs.take(n)
    end

    private
      def hexs
        %w( #E25241 #75038E #12A6A6 #C79553 #ffce56
            #1B5E20 #F47E3D #DFC5F1 #4127B1 #E87CB9
            #B953F6 #827717 #D50000 #2962FF #2F3559 )
      end
  end
end
