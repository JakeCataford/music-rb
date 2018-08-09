require 'music/utils/ring'
require 'music/modes'

module Music
  ##
  # A class representing a musical scale, which is a set of intervals
  # describing where the next note in the sequence is.
  class Scale
    attr_reader :intervals

    ##
    # Factory method for a major scale
    def self.major
      new([2,2,1,2,2,2,1])
    end

    ##
    # Factory method for a minor scale
    def self.minor
      major.mode(Modes::AEOLIAN)
    end

    ##
    # Constructs a new scale from a Ring or Array of intervals
    def initialize(intervals)
      @intervals = Utils::Ring.wrap(intervals)
    end

    def interval(n)
      @intervals[n]
    end

    ##
    # Returns the n'th mode of the scale, specified by a base 0 degree
    # NOTE: this means that 0 will return the Ionian mode, and 5 will
    # return the Aeolian mode. To avoid mistakes, pass a constant from
    # Music::Modes.
    def mode(degree)
      Scale.new(intervals.rotate(degree))
    end

    ##
    # Gets the interval from the root. Summing up all of the intervals from
    # 0 - degree (including in the negative direction)
    def jump(end_degree, start_degree = 0)
      (start_degree...end_degree).sum do |i|
        intervals[i]
      end
    end

    ##
    # Returns, given a root note, how many notes in the scale away that note is.
    # if the note is not on the scale, it returns in the decimal how close the
    # next note in the scale is
    def steps_from_root(root_note, note)
      normalized_note = note.normalize
      normalized_root = root_note.normalize

      normalized_note = normalized_note + 12 if normalized_note < normalized_root
      distance = normalized_note - normalized_root

      steps = 0
      traveled_distance = 0

      loop do
        interval = jump(steps)
        return steps if interval == distance

        next_interval = jump(steps + 1)
        if next_interval > distance
          decimal = (distance.to_f - interval.to_f)/(next_interval.to_f - interval.to_f)
          return steps.to_f + decimal
        end

        steps += 1
      end
    end

    ##
    # Scales are considered equal if they contain the same intervals
    def ==(other)
      @intervals == other.intervals
    end
  end
end
