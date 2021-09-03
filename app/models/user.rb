# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :active_users_relationships,
           class_name: 'UsersRelationship',
           foreign_key: 'follower_id',
           dependent: :destroy,
           inverse_of: :follower
  has_many :passive_users_relationships,
           class_name: 'UsersRelationship',
           foreign_key: 'following_id',
           dependent: :destroy,
           inverse_of: :following
  has_many :followings, through: :active_users_relationships
  has_many :followers, through: :passive_users_relationships

  def follow(user)
    followings << user
  end

  def unfollow(user)
    active_users_relationships.find_by(following_id: user.id).destroy
  end

  def following?(user)
    followings.include? user
  end
end
