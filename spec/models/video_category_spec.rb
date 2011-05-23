require 'spec_helper'

describe VideoCategory do
  context 'validations' do
    it { should validate_presence_of(:name) }
    context 'uniqueness' do
      before { Factory(:video_category) }
      it { should validate_uniqueness_of(:name) }
    end
  end

  context 'factory' do
    it { should have_valid_factory(:video_category) }
  end
end
