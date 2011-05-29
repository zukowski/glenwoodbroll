require 'spec_helper'

describe Collection do
  context 'validations' do
    it { should belong_to(:user) }
    it { should have_and_belong_to_many(:videos) }
    it { should validate_presence_of(:user) }
  end

  context 'factories' do
    it { should have_valid_factory(:collection) }
    context 'collection with videos' do
      it { should have_valid_factory(:collection_with_videos) }
      context 'videos' do
        it 'should have videos' do
          Factory(:collection_with_videos).videos.should_not be_empty
        end
      end
    end
  end
end
