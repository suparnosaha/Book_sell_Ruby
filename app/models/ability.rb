# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    if user
      if user.is_admin?
        #if admin can do anything
        can :manage, :all

        # cannot destroy self
        cannot :destroy, User do |this_user|
          user.is_admin? && this_user.is_admin? && user.id == this_user.id
        end
      end

      #rules for registered user

      # Create Rules
      can :create, [Review, Cart, Transaction]

      # Read Rules
      can :read, [Book, Review]
      can :read, User, id: user.id
      can :read, Cart do |cart|
        cart.user == user
      end
      can :read, Transaction, user_id: user.id

      # Update Rules
      can :update, User, id: user.id
      can :update, Review, user_id: user.id
      can :update, Cart do |cart|
        cart.user == user && cart.transaction_id == nil
      end

      # Delete Rules
      can :destroy, User, id: user.id
      can :destroy, Review, user_id: user.id
      can :destroy, Cart do |cart|
        cart.user == user && cart.transaction_id == nil
      end

      # Additional Rules for Cart
      can :check, Cart

    end
  end
end
