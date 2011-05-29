require 'spec_helper'

describe Video do
  context 'validations' do
    it { should belong_to(:video_category) }
    it { should have_and_belong_to_many(:video_collections) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:video_category) }
    it { should validate_numericality_of(:duration) }
    it { should_not allow_value(5.5).for(:duration) }
  end

  context 'factory' do
    it { should have_valid_factory(:video) }
  end

  context '#search' do
    context 'when no params are supplied' do
      it 'should return all videos' do
        3.times { Factory(:video) }
        Video.search({}).count.should == 3
      end
    end

    context 'when keywords are supplied' do
      it 'should limit videos with keywords in title' do
        video1 = Factory(:video, :title => "One")
        video2 = Factory(:video, :title => "Two")
        Video.search({:keywords => "Two"}).should == [video2]
      end

      it 'should limit videos with keywords in description' do
        video1 = Factory(:video, :description => "One")
        video2 = Factory(:video, :description => "Two")
        Video.search({:keywords => "Two"}).should == [video2]
      end
    end

    context 'when a category is supplied' do
      it 'should limit the videos to that category' do
        video1 = Factory(:video)
        video2 = Factory(:video)
        Video.search({:category_id => video2.video_category.id}).should == [video2]
      end
    end

    context 'when a category and keywords are supplied' do
      it 'should only return videos with matching category and keywords' do
        video1 = Factory(:video, :title => "One")
        video2 = Factory(:video, :title => "One")
        video3 = Factory(:video, :video_category => video2.video_category)
        Video.search({:category_id => video2.video_category.id, :keywords => "One"}).should == [video2]
      end
    end
  end
end
