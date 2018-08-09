require 'spec_helper'

module Music
  module Utils
    RSpec.describe Ring do
      describe "the ring class" do
        it "can wrap an array to return a ring" do
          expect(Ring.wrap([1,2,3])).to eq(Ring.new([1,2,3]))
        end

        it "can wrap an ring to return a ring" do
          expect(Ring.wrap(Ring.new([1,2,3]))).to eq(Ring.new([1,2,3]))
        end
      end

      describe "a ring with some elements" do
        before :example do
          @subject = Ring.new([1,2,3,4,5])
        end

        it "is equal to another ring containing equal elements" do
          expect(Ring.new([1,2,3])).to eq(Ring.new([1,2,3]))
        end

        it "can be accessed within the input list's bounds" do
          expect(@subject[0]).to eq(1)
          expect(@subject[3]).to eq(4)
          expect(@subject[4]).to eq(5)
        end

        it "loops indexes when index is > input list length" do
          expect(@subject[5]).to eq(1)
          expect(@subject[8]).to eq(4)
          expect(@subject[9]).to eq(5)
        end

        it "loops indexes when index is < 0" do
          expect(@subject[-1]).to eq(5)
          expect(@subject[-4]).to eq(2)
        end
      end

      describe "a ring with no elements" do
        before :example do
          @subject = Music::Utils::Ring.new([])
        end

        it "raises IndexError when accessed" do
          expect { @subject[1] }.to raise_error(IndexError)
        end
      end
    end
  end
end
