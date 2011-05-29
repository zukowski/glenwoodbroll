class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif not user.new_record?
      can :read, Video
      can :read, Category
      can :read, Collection, :user_id => user.id
      can :create, Collection
      can :update, Collection, :user_id => user.id
      can :destroy, Collection, :user_id => user.id
      can :show, User, :id => user.id
    end
  end
end
