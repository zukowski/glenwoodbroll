require 'spec_helper'

describe Category do
  context 'validations' do
    it { should have_many(:videos) }
    it { should validate_presence_of(:name) }
    context 'uniqueness' do
      before { Factory(:category) }
      it { should validate_uniqueness_of(:name) }
    end
  end

  context 'factory' do
    it { should have_valid_factory(:category) }
  end
end
