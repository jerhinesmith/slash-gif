require 'rails_helper'

RSpec.describe Gif, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:gif)).to be_valid
  end

  describe '.random' do
    context "with no records" do
      it 'should raise NotFound' do
        expect { Gif.random }.to          raise_error(ActiveRecord::RecordNotFound)
        expect { Gif.random(['tag']) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "with multiple records" do
      before do
        @tags = FactoryGirl.create_list(:tag, 5)
        @gifs = @tags.collect{|t| FactoryGirl.create_list(:gif, rand(1..3), tag_list: t.name)}.flatten
      end

      context "with no argument" do
        it 'should return a random Gif' do
          gif = Gif.random

          expect(gif).to be_instance_of(Gif)
          expect(@gifs).to include(gif)
        end
      end

      context "with a tag" do
        it 'should return a random Gif with that tag' do
          tag = @tags.sample
          gif = Gif.random([tag])

          expect(gif).to be_instance_of(Gif)
          expect(@gifs).to include(gif)
          expect(gif.tags).to include(tag)
        end
      end
    end
  end
end
