require 'spec_helper'

module Music
  RSpec.describe Note do
    describe '#name' do
      it 'resolves note 0 to C0' do
        expect(Note.new(0).name).to eq('C0')
      end

      it 'resolves note 14 to D1' do
        expect(Note.new(14).name).to eq('D1')
      end

      it 'resolves note 15 to D#1 in default context' do
        expect(Note.new(15).name).to eq('D#1')
      end

      it 'resolves note 15 to Eb1 in flat context' do
        expect(Note.new(15).name(context: :flat)).to eq('Eb1')
      end

      it 'resolves note 45 to A5' do
        expect(Note.new(45).name).to eq('A3')
      end
    end

    describe 'middle c' do
      before :example do
        @subject = Note.middle_c
      end

      it 'is C3' do
        expect(@subject.name).to eq('C3')
      end
    end
  end
end
