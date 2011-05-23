require 'spec_helper'

describe User do
  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:password) }
    it { should allow_mass_assignment_of(:password_confirmation) }
  end

  context 'factory' do
    context 'user' do
      it { should have_valid_factory(:user) }
    end
  end
end
