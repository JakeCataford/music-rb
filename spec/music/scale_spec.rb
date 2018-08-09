require 'spec_helper'

module Music
  RSpec.describe Scale do
    describe 'the scale class' do
      it 'can construct major scales' do
        expect(Scale.major).to eq(Scale.new([2,2,1,2,2,2,1]))
      end

      it 'can construct minor (6th mode) scales' do
        expect(Scale.minor).to eq(Scale.new([2,2,1,2,2,2,1]).mode(5))
      end
    end

    describe 'the major scale' do
      before :example do
        @subject = Scale.major
      end

      it 'can return a mode of a particular scale' do
        expect(@subject.mode(1)).to eq(Scale.new([2,1,2,2,2,1,2]))
      end

      it 'can return the jump interval to a particular scale degree' do
        expect(@subject.jump(2)).to eq(4)
        expect(@subject.jump(7)).to eq(12)
      end

      it 'can return the correct number of steps from a root note' do
        expect(@subject.steps_from_root(Note.new(50), Note.new(52))).to eq(1)
        expect(@subject.steps_from_root(Note.new(50), Note.new(53))).to eq(1.5)
        expect(@subject.steps_from_root(Note.new(50), Note.new(49))).to eq(6)
      end

      it 'can return the nth interval' do
        expect(@subject.interval(2)).to eq(1)
      end
    end
  end
end
