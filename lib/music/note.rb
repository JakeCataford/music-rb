require 'music/scale'
require 'music/utils/delegate'

module Music
  class Note
    include Music::Utils::Delegate

    def self.middle_c
      new(36)
    end

    delegate :+, :-, to: :@semitones
    attr_reader :semitones

    def initialize(semitones)
      @semitones = semitones
    end

    ##
    # Reduces the note to its position in a single octave
    def normalize
      @semitones = @semitones % 12
    end

    def name(context: :sharp)
      raise InvalidArgumentError, "context must be :sharp or :flat" unless [:sharp, :flat].include?(context)
      octaves = @semitones/12
      note_in_octave = @semitones % 12
      note_names = ['C', 'D', 'E', 'F', 'G', 'A', 'B']

      note = Scale.major.steps_from_root(Note.new(0), self)

      if context == :sharp
        name = note_names[note.floor]
        name << "#" if note != note.floor
      else
        name = note_names[note.ceil]
        name << "b" if note != note.ceil
      end

      name << octaves.to_s
      name
    end
  end
end
