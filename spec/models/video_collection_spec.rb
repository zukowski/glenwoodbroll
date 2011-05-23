require 'spec_helper'

describe VideoCollection do
  context 'validations' do
    it { should belong_to(:user) }
    it { should have_and_belong_to_many(:videos) }
    it { should validate_presence_of(:user) }
  end

  context 'factories' do
    it { should have_valid_factory(:video_collection) }
    context 'video collection with videos' do
      it { should have_valid_factory(:video_collection_with_videos) }
      context 'videos' do
        subject { Factory(:video_collection_with_videos).videos }
        it { should_not be_empty }
      end
    end
  end
end
