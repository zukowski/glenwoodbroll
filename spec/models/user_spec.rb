require 'spec_helper'

describe User do
  context 'validations' do
    it { should have_many(:collections) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:password) }
    it { should allow_mass_assignment_of(:password_confirmation) }
    it { should_not allow_mass_assignment_of(:admin) }
  end

  context 'factory' do
    context 'user' do
      it { should have_valid_factory(:user) }
      it { should have_valid_factory(:admin) }
    end
  end

  context '#is_admin!' do
    it 'should make the user an admin' do
      user = Factory(:user)
      user.is_admin!
      user.reload.should be_admin
    end
  end

  context '#is_not_admin!' do
    it 'should make the user not an admin' do
      user = Factory(:admin)
      user.is_not_admin!
      user.reload.should_not be_admin
    end
  end
end
