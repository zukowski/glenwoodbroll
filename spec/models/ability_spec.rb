require 'spec_helper'
require 'cancan/matchers'

describe Ability do

  before :all do
    @user = Factory(:user)
    @admin = Factory(:admin)
    @admin_ability = Ability.new(@admin)
    @user_ability = Ability.new(@user)
    @video = Factory(:video)
    @video_category = @video.category
    @admin_collection = Factory(:collection, :user => @admin)
    @user_collection = Factory(:collection, :user => @user)
  end

  after :all do
    [User,Video,Collection,Category].each(&:destroy_all)
  end

  context 'admin' do
    it 'should be able to manage all' do
      @admin_ability.should be_able_to(:manage, :all)
    end
  end

  context 'non-admin' do
    context 'Video' do
      context 'should be able to' do
        it 'to see videos' do
          @user_ability.should be_able_to(:read, @video)
        end  
      end

      context 'should not be able to' do
        it 'create a video' do
          @user_ability.should_not be_able_to(:create, Video)
        end

        it 'modify videos' do
          @user_ability.should_not be_able_to(:update, @video)
        end

        it 'destroy videos' do
          @user_ability.should_not be_able_to(:destroy, @video)
        end
      end
    end

    context 'Category' do
      context 'should be able to' do
        it 'should be able to see video categories' do
          @user_ability.should be_able_to(:read, @video_category)
        end
      end

      context 'should not be able to' do
        it 'create video categories' do
          @user_ability.should_not be_able_to(:create, Category)
        end

        it 'update video categories' do
          @user_ability.should_not be_able_to(:update, @video_category)
        end

        it 'destroy video categories' do
          @user_ability.should_not be_able_to(:destroy, @video_category)
        end
      end
    end

    context 'Collection' do
      context 'should be able to' do
        it 'read their own video collections' do
          @user_ability.should be_able_to(:read, @user_collection)
        end

        it 'create a video collection' do
          @user_ability.should be_able_to(:create, Collection)
        end

        it 'update their own video collection' do
          @user_ability.should be_able_to(:update, @user_collection)
        end

        it 'destroy their own video collections' do
          @user_ability.should be_able_to(:destroy, @user_collection)
        end
      end

      context 'should not be able to' do
        it 'read the collections of others' do
          @user_ability.should_not be_able_to(:read, @admin_collection)
        end

        it 'update the collections of others' do
          @user_ability.should_not be_able_to(:update, @admin_collection)
        end

        it 'destroy the collections of others' do
          @user_ability.should_not be_able_to(:destroy, @admin_collection)
        end
      end
    end

    context 'User' do
      context 'should be able to' do
        it 'see their own user profile' do
          @user_ability.should be_able_to(:show, @user)
        end
      end

      context 'should not be able to' do
        it 'see all users' do
          @user_ability.should_not be_able_to(:index, User)
        end

        it 'see other user profiles' do
          @user_ability.should_not be_able_to(:show, @admin)
        end

        it 'create a user' do
          @user_ability.should_not be_able_to(:create, User)
        end

        it 'update users' do
          @user_ability.should_not be_able_to(:update, @admin)
        end

        it 'destroy users' do
          @user_ability.should_not be_able_to(:destroy, @admin)
        end
      end
    end
  end
end
