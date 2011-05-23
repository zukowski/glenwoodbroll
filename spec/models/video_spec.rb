require 'spec_helper'

describe Video do
  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:duration) }
    it { should_not allow_value(5.5).for(:duration) }
  end

  context 'factory' do
    it { should have_valid_factory(:video) }
  end
end