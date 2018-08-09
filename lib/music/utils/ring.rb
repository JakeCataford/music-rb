module Music
  module Utils
    class Ring < Array
      def self.wrap(array_or_ring)
        return array_or_ring if array_or_ring.is_a? Ring
        return new(array_or_ring) if array_or_ring.is_a? Array
        raise InvalidArgumentError, "Ring.wrap recieved a #{array_or_ring.class}, expected Ring or Array"
      end

      def [](index)
        raise IndexError, "Cannot access ring with 0 elements" if length == 0
        super(index % length)
      end
    end
  end
end
