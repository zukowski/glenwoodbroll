class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif not user.new_record?
      can :read, Video
      can :read, VideoCategory
      can :read, VideoCollection, :user_id => user.id
      can :create, VideoCollection
      can :update, VideoCollection, :user_id => user.id
      can :destroy, VideoCollection, :user_id => user.id
      can :show, User, :id => user.id
    end
  end
end
